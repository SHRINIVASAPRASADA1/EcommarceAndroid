import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:myapp/variables.dart';

class HistoryOfUser extends StatefulWidget {
  const HistoryOfUser({Key? key}) : super(key: key);

  @override
  State<HistoryOfUser> createState() => _HistoryOfUserState();
}

class _HistoryOfUserState extends State<HistoryOfUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(userIn!.email)
            .collection("history")
            .orderBy("date")
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError) {
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
                    .doc(snapshot.data!.docs[index]['productId'].toString())
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> product) {
                  if (product.connectionState == ConnectionState.waiting ||
                      product.hasError) {
                    return Center(
                      child: Container(),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(product.data!['img'][0]),
                      title: Text(product.data!['title']),
                      // hoverColor: Colors.green,
                      subtitle: Text(product.data!['price'].toString()),
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
