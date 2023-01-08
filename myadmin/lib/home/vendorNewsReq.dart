import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myadmin/vari.dart';

class VendorNewsReq extends StatefulWidget {
  const VendorNewsReq({Key? key}) : super(key: key);

  @override
  State<VendorNewsReq> createState() => _VendorNewsReqState();
}

class _VendorNewsReqState extends State<VendorNewsReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("requestNews")
            .where("date", isEqualTo: DateTime.now().day)
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
              return GestureDetector(
                onLongPress: () {
                  FirebaseFirestore.instance.collection("News").add({
                    "date": DateTime.now().day,
                    "des": snapshot.data!.docs[index]['des'],
                    "imglink": snapshot.data!.docs[index]['imglink'],
                    "myorder": DateTime.now(),
                  });
                  FirebaseFirestore.instance
                      .collection("requestNews")
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
    );
  }
}
