import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myadmin/home/UpdateCatogory.dart';
import 'package:myadmin/vari.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("News")
            .where("date", isEqualTo: DateTime.now().day)
            .snapshots(),
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
                onLongPress: () {
                  FirebaseFirestore.instance
                      .collection("News")
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.2,
                      color: Colors.white,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: addHeight(context, 0.60),
                        padding: const EdgeInsets.all(10),
                        child: Image.network(
                            snapshot.data!.docs[index]['imglink']),
                      ),
                      Text(DateTime.now().toString()),
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(snapshot.data!.docs[index]['des']),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection("News").add({
                      "date": DateTime.now().day,
                      "myorder": DateTime.now(),
                      "imglink": imglinkfornews,
                      "des": newsdes.text,
                    });
                    Navigator.pop(context);
                    newsdes.text = "";
                    imglinkfornews = "";
                  },
                  child: const Icon(Icons.send),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: imagnameN,
                    decoration: const InputDecoration(
                      labelText: "imgname",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0.3,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
                GestureDetector(
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
                          imglinkfornews = (await uploadImageToFirebase(
                              myfile, DateTime.now().toString()) as String);
                        });
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.add,
                      size: 83,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: newsdes,
                    maxLines: 10,
                    maxLength: 20000,
                    decoration: const InputDecoration(
                      hintMaxLines: 20,
                      labelText: "Description",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0.3,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
