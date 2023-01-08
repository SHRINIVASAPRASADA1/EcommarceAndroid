import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myadmin/vari.dart';

class UserCart extends StatefulWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(currentHistory)
            .collection("cart")
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
              return Dismissible(
                onDismissed: (DismissDirection) {
                  FirebaseFirestore.instance
                      .collection("AllUser")
                      .doc(currentHistory)
                      .collection("cart")
                      .doc(snapshot.data!.docs[index].id.toString())
                      .delete();
                },
                key: Key(snapshot.data!.docs[index].id.toString()),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(53, 171, 168, 168),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      snapshot.data!.docs[index]['img'],
                    ),
                    title: Text(
                      snapshot.data!.docs[index]['title'].toString(),
                    ),
                    subtitle: Text(snapshot.data!.docs[index]['id']),
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
