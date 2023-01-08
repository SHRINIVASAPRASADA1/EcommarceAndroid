import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:myapp/component/payment.dart';
import 'package:myapp/variables.dart';

class BillingOnItem extends StatefulWidget {
  const BillingOnItem({Key? key}) : super(key: key);

  @override
  State<BillingOnItem> createState() => _BillingOnItemState();
}

class _BillingOnItemState extends State<BillingOnItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
            // color: Colors.black,
            ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(userIn!.email.toString())
            .collection("address")
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting ||
              snapshot2.hasError) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  height: 80,
                  width: double.infinity,
                );
              },
            );
            ;
          }
          return SingleChildScrollView(
            child: Wrap(
              children: [
                for (var item in snapshot2.data!.docs)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            addId: item.id.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: widthis(context, 0.45),
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                        left: widthis(context, 0.02),
                        right: widthis(context, 0.02),
                        top: heightof(context, 0.02),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(66, 255, 249, 249),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            // spreadRadius: 1,
                            // blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                        border: Border.all(
                          width: 0.02,
                          // color: Colors.black,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(item['name']),
                          Text(item['state']),
                          Text(item['city']),
                          Text(item['pincode']),
                          Text(item['areaNear']),
                          Text(item['mobileNumber']),
                          Text(item['street']),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
