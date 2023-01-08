import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/vendorsProduct.dart';

class SellersProfile extends StatefulWidget {
  const SellersProfile({Key? key}) : super(key: key);

  @override
  State<SellersProfile> createState() => _SellersProfileState();
}

class _SellersProfileState extends State<SellersProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("sellers").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.connectionState == ConnectionState.waiting ||
            !snapshot1.hasData ||
            snapshot1.hasError) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                height: MediaQuery.of(context).size.height * 0.20,
                child: const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
              );
            },
          );
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot1.data!.docs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VendorProduct(
                      vendorId: snapshot1.data!.docs[index].id.toString(),
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                height: MediaQuery.of(context).size.height * 0.20,
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(82, 255, 255, 255),
                  radius: 35,
                  backgroundImage:
                      NetworkImage(snapshot1.data!.docs[index]["img"]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
