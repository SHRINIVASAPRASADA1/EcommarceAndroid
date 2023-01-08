// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myapp/component/cartItemBuy.dart';
import 'package:myapp/variables.dart';

class SelectAddress extends StatefulWidget {
  int? amt;
  SelectAddress({Key? key, required this.amt}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(151, 72, 47, 240),
          ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(userIn!.email)
            .collection("address")
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
          return ListView.builder(
            itemCount: snapshot1.data!.docs.length,
            itemBuilder: (context, index) {
              if (!snapshot1.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      // backgroundColor: Colors.purple,
                      ),
                );
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartItemBuy(),
                    ),
                  );
                  setState(() {
                    selectedAddress = snapshot1.data!.docs[index].id;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(66, 255, 126, 79),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot1.data!.docs[index]['name'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['state'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['city'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['street'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['areaNear'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['pincode'],
                      ),
                      Text(
                        snapshot1.data!.docs[index]['mobileNumber'],
                      ),
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
