// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/vari.dart';

class UserHistory extends StatefulWidget {
  UserHistory({Key? key}) : super(key: key);

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(currentHistory.toString())
            .collection("history")
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(snapshot.data!.docs[index]['productId'])
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id.toString()),
                    // ignore: avoid_types_as_parameter_names
                    onDismissed: (DismissDirection) {
                      FirebaseFirestore.instance
                          .collection("AllUser")
                          .doc(currentHistory.toString())
                          .collection("history")
                          .doc(snapshot.data!.docs[index].id.toString())
                          .delete();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.1,
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          snapshot1.data!['img'][0],
                        ),
                        title: Text(snapshot1.data!['title']),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
