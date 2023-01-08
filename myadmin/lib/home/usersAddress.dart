import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/vari.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(currentHistory)
            .collection("address")
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
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.2,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(snapshot.data!.docs[index].id.toString()),
                    Text(snapshot.data!.docs[index]['name']),
                    Text(snapshot.data!.docs[index]['street']),
                    Text(snapshot.data!.docs[index]['state']),
                    Text(snapshot.data!.docs[index]['pincode']),
                    Text(snapshot.data!.docs[index]['mobileNumber']),
                    Text(snapshot.data!.docs[index]['city']),
                    Text(snapshot.data!.docs[index]['areaNear']),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
