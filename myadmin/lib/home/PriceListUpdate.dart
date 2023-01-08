// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/vari.dart';

class PriceListUpdate extends StatefulWidget {
  const PriceListUpdate({Key? key}) : super(key: key);

  @override
  State<PriceListUpdate> createState() => _PriceListUpdateState();
}

class _PriceListUpdateState extends State<PriceListUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("priceList").snapshots(),
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
                  FirebaseFirestore.instance
                      .collection("priceList")
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
                child: Container(
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
                      width: 0.4,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    subtitle: const Text("User Of App"),
                    leading: const Icon(
                      Icons.price_change,
                    ),
                    title: Text(
                      snapshot.data!.docs[index]['price'],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CupertinoButton(
        child: const Text("Add Amount"),
        onPressed: () {
          showModalBottomSheet(
            isDismissible: true,
            context: context,
            builder: (context) => Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: amtPricelist,
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("priceList")
                                .doc(amtPricelist.text.toString())
                                .set({
                              "price": amtPricelist.text.toString(),
                            });
                            amtPricelist.text = "";
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.done,
                          ),
                        ),
                        labelText: "Enter Amount",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
