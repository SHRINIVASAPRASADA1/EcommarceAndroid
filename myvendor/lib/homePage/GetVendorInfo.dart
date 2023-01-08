import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myvendor/homePage/HomePage.dart';
import 'package:myvendor/variable.dart';

class GetVendorInfo extends StatefulWidget {
  const GetVendorInfo({Key? key}) : super(key: key);

  @override
  State<GetVendorInfo> createState() => _GetVendorInfoState();
}

class _GetVendorInfoState extends State<GetVendorInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userIn!.email.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: const Color.fromARGB(70, 255, 255, 255),
                child: const Text(
                  "Fetch My Data",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  fetchFunction();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameOfVender,
                decoration: const InputDecoration(
                    labelText: "Name ",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.02,
                    ))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: products,
                decoration: const InputDecoration(
                    labelText: "products | stock avilable ",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.02,
                    ))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: from,
                decoration: const InputDecoration(
                    labelText: "from ",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.02,
                    ))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameOfVender,
                decoration: InputDecoration(
                    suffix: GestureDetector(
                      onTap: () {
                        setState(
                          () async {
                            final ImagePicker _picker = ImagePicker();
                            setState(() async {
                              XFile? image = (await _picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 70,
                              ));
                              File myfile = File(image!.path);
                              profileLink = (await uploadImageToFirebase(
                                  myfile, DateTime.now().toString()) as String);
                            });
                          },
                        );
                      },
                      child: const Icon(Icons.image),
                    ),
                    labelText: "Image Name ",
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.02,
                    ))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: profileLink != ""
                  ? Image.network(profileLink.toString())
                  : const Icon(
                      Icons.file_copy_outlined,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          FirebaseFirestore.instance
              .collection("sellers")
              .doc(userIn!.email)
              .set({
            "blocked": false,
            "canuploadnews": false,
            "canuploadproduct": true,
            "dateofjoin": DateTime.now(),
            "from": from.text,
            "img": profileLink,
            "name": nameOfVender.text,
            "products": products.text,
          });
          from.text = "";
          profileLink = "";
          nameOfVender.text = "";
          products.text = "";
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

Future<String?> uploadImageToFirebase(File imageFile, String location) async {
  String? dowloadUrl;
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref(location);

  firebase_storage.UploadTask task = ref.putFile(imageFile);
  firebase_storage.TaskSnapshot snapshot = await task;

  await snapshot.ref
      .getDownloadURL()
      .then((value) => dowloadUrl = value.toString());
  return dowloadUrl;
}
