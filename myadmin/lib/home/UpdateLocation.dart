// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/vari.dart';

class UpdateLocation extends StatefulWidget {
  String id = "";
  UpdateLocation({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .doc(widget.id.toString())
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
                return Container(
                  width: addwidth(context, 1),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.1,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!['buyer']),
                      Text(snapshot.data!['paid'].toString()),
                      // Text(snapshot.data!['mobileNumber'].toString()),
                      Text(snapshot.data!['product_id']),
                      const Text(
                        "Current Delivered Location  :",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (var item = 0;
                          item < snapshot.data!['state'].length;
                          item++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: addHeight(context, 0.09),
                              color: Colors.green,
                              width: addwidth(context, 0.01),
                            ),
                            ListTile(
                              onLongPress: () {
                                FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(widget.id)
                                    .update({
                                  "state": FieldValue.arrayRemove(
                                      [snapshot.data!['state'][item]])
                                });
                              },
                              leading: const Icon(
                                Icons.fire_truck_outlined,
                              ),
                              title: Text(snapshot.data!['state'][item]),
                            ),
                          ],
                        ),
                      Container(
                        margin: EdgeInsets.only(
                          top: addHeight(
                            context,
                            0.05,
                          ),
                        ),
                        child: TextField(
                          controller: nextLoc,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(widget.id)
                                    .update({
                                  "state": FieldValue.arrayUnion([
                                    nextLoc.text,
                                  ]),
                                });
                                nextLoc.text = "";
                              },
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                            labelText: "Add Next Location !",
                            labelStyle: const TextStyle(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.2,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
