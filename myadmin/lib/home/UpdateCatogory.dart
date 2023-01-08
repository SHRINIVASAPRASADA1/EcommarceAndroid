// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myadmin/vari.dart';

class UpdateCatogory extends StatefulWidget {
  const UpdateCatogory({Key? key}) : super(key: key);

  @override
  State<UpdateCatogory> createState() => _UpdateCatogoryState();
}

class _UpdateCatogoryState extends State<UpdateCatogory> {
  String keywordsOnchenage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(downloadUrl.toLowerCase()),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("catogory").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    builder: (context) => Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: keywords,
                                decoration: InputDecoration(
                                  suffix: IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("catogory")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        "keyword": FieldValue.arrayUnion([
                                          keywords.text,
                                        ])
                                      });
                                      keywords.text = "";
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.upload,
                                      color: Colors.white,
                                    ),
                                  ),
                                  labelText: "ADD KEYWORD !",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 70,
                                );
                                String link = await uploadImageToFirebase(
                                    image as File, image.toString()) as String;

                                FirebaseFirestore.instance
                                    .collection("catogory")
                                    .doc(snapshot.data!.docs[index].id)
                                    .update({
                                  "logo": link,
                                });
                                setState(() {
                                  link = "";
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['logo'],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                "Name :  ${snapshot.data!.docs[index]['name']}"),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: addHeight(context, 0.005),
                              margin: const EdgeInsets.all(15),
                            ),
                            for (var i = 0;
                                i <
                                    snapshot
                                        .data!.docs[index]['keyword'].length;
                                i++)
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("catogory")
                                      .doc(snapshot.data!.docs[index].id)
                                      .update({
                                    "keyword": FieldValue.arrayRemove(
                                      [
                                        snapshot.data!.docs[index]['keyword']
                                            [i],
                                      ],
                                    ),
                                  });
                                  Navigator.pop(context);
                                },
                                hoverColor:
                                    const Color.fromARGB(73, 255, 255, 255),
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "$i . ${snapshot.data!.docs[index]['keyword'][i].toString()}",
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(195, 0, 0, 0),
                        blurRadius: 3,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                    border: Border.all(
                      width: 0.4,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    subtitle: const Text("Tap to Edit"),
                    leading: const Icon(
                      Icons.price_change,
                    ),
                    title: Text(
                      snapshot.data!.docs[index].id.toString(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CupertinoButton(
        child: const Text("Add Catogory"),
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(5),
                    child: CupertinoTextField(
                      controller: catogoryAdd,
                      cursorColor: Colors.white,
                      placeholderStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      placeholder: "Enter Name Of Catogory ",
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      imgfile = File(image!.path.toString());
                      Reference reference =
                          ref.ref().child("catogory${catogoryAdd.text} ");

                      Future<TaskSnapshot> uploading =
                          reference.putFile(imgfile!);
                      String downloadUrl =
                          (await reference.getDownloadURL()).toString();
                      setState(() {
                        linkSelected = downloadUrl;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.file_open,
                        size: addwidth(context, 0.20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          keywordsOnchenage = val;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            userKe.add(keywordsOnchenage.toString());
                            keywordsOnchenage = "";
                          },
                          child: const Icon(Icons.add),
                        ),
                        labelText: "Enter Keyword",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(4),
                    child: CupertinoButton(
                      child: const Text("Add Catogory"),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("catogory")
                            .doc(
                              catogoryAdd.text.toString(),
                            )
                            .set({
                          "date": DateTime.now(),
                          "name": catogoryAdd.text.toString(),
                          "keyword": userKe,
                          "logo": linkSelected,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final ImagePicker _picker = ImagePicker();

final ref = FirebaseStorage.instance;

// uploadImage(BuildContext context, name) async {
//   var image = await _picker.pickImage(
//     source: ImageSource.gallery,
//     imageQuality: 70,
//   );
//   imgfile = File(image!.path.toString());
//   Reference reference = ref.ref("img/").child("n" + name);

//   reference.putFile(imgfile!);
//   String downloadUrl = (await reference.getDownloadURL()).toString();

//   return downloadUrl;
// }

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
