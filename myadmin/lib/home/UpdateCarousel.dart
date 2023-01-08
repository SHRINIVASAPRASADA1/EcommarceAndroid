// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateCaroselSlider extends StatefulWidget {
  const UpdateCaroselSlider({Key? key}) : super(key: key);

  @override
  State<UpdateCaroselSlider> createState() => _UpdateCaroselSliderState();
}

class _UpdateCaroselSliderState extends State<UpdateCaroselSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("carouselSlider").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (DismissDirection) {
                  FirebaseFirestore.instance
                      .collection("carouselSlider")
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
                key: Key(snapshot.data!.docs[index].id),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(49, 231, 214, 214),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.black,
                    ),
                  ),
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index]['title']),
                    leading: Image.network(
                      snapshot.data!.docs[index]['img'],
                      fit: BoxFit.cover,
                    ),
                    subtitle: Text(
                      snapshot.data!.docs[index]['id'].toString(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CupertinoButton(
        child: const Text("Add Products"),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 0.01,
                  color: Colors.white,
                ),
              ),
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("products").get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("carouselSlider")
                              .add({
                            "img":
                                snapshot.data!.docs[index]['img'][0].toString(),
                            "id": snapshot.data!.docs[index].id,
                            "dateOfAdd": DateTime.now(),
                            "title": snapshot.data!.docs[index]['title'],
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(7),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(86, 251, 249, 249),
                            border: Border.all(
                              width: 0.01,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              snapshot.data!.docs[index]['img'][0],
                            ),
                            title: Text(snapshot.data!.docs[index]['title']),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
