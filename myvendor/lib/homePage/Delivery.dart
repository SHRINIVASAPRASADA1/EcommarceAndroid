import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myvendor/variable.dart';

class DeliveryUpdate extends StatefulWidget {
  const DeliveryUpdate({Key? key}) : super(key: key);

  @override
  State<DeliveryUpdate> createState() => _DeliveryUpdateState();
}

class _DeliveryUpdateState extends State<DeliveryUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("orders")
            .where("vendor", isEqualTo: userIn!.email)
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
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(3),
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
                      width: 0.1,
                      color: Colors.black,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                    ),
                    title: Text(
                      snapshot.data!.docs[index]['buyer'],
                    ),
                    subtitle: Text(
                      snapshot.data!.docs[index]['product_id'],
                    ),
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
