// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/component/writeComment.dart';
import 'package:myapp/variables.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackMyOrder extends StatefulWidget {
  String proId = "";
  TrackMyOrder({Key? key, required this.proId}) : super(key: key);

  @override
  State<TrackMyOrder> createState() => _TrackMyOrderState();
}

class _TrackMyOrderState extends State<TrackMyOrder> {
  TextEditingController reason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(200, 112, 44, 239),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("orders")
                  .doc(widget.proId)
                  .get(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("products")
                          .doc(snapshot2.data!['product_id'])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot3) {
                        if (snapshot3.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                left: widthis(context, 0.10),
                                right: widthis(context, 0.10),
                                top: widthis(context, 0.02),
                                bottom: widthis(context, 0.02),
                              ),
                              height: heightof(context, 0.40),
                              child: Image.network(
                                snapshot3.data!['img'][0],
                              ),
                            ),
                            Text(
                              snapshot3.data!['title'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              " ₹ ${snapshot3.data!['price'].toString()}",
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                          ],
                        );
                      },
                    ),
                    Text(
                      "Email : ${snapshot2.data!['buyer']}",
                      style: const TextStyle(shadows: [
                        Shadow(
                          // color: Color.fromARGB(140, 0, 0, 0),
                          blurRadius: 2.0,
                          offset: Offset(1.0, 1.0),
                        )
                      ]),
                    ),
                    Text(
                      " Payment Status :  ${snapshot2.data!['paid'] == true ? "paid" : "cash on delivery"}",
                      style: const TextStyle(shadows: [
                        Shadow(
                          // color: Color.fromARGB(140, 0, 0, 0),
                          blurRadius: 2.0,
                          offset: Offset(1.0, 1.0),
                        )
                      ]),
                    ),
                    // Text(" ${snapshot2.data!['date']}"),

                    for (int i = 0;
                        i <= snapshot2.data!['state'].length - 1;
                        i++)
                      TimelineTile(
                        beforeLineStyle: const LineStyle(
                          // color: Colors.green,
                          thickness: 4,
                        ),
                        hasIndicator: true,
                        indicatorStyle: IndicatorStyle(
                          drawGap: true,
                          width: widthis(context, 0.02),
                          padding: const EdgeInsets.all(5),
                          height: heightof(context, 0.30),
                        ),
                        axis: TimelineAxis.vertical,
                        alignment: TimelineAlign.manual,
                        lineXY: 0.2,
                        endChild: Text(
                          snapshot2.data!['state'][i],
                          style: const TextStyle(shadows: [
                            Shadow(
                              // color: Color.fromARGB(140, 0, 0, 0),
                              blurRadius: 2.0,
                              offset: Offset(1.0, 1.0),
                            )
                          ]),
                        ),
                      ),

                    CupertinoButton(
                      child: const Text("Cancel My order"),
                      onPressed: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SafeArea(
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      height: heightof(context, 0.010),
                                      width: widthis(context, 0.30),
                                      decoration: BoxDecoration(
                                        // color:
                                        // const Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: TextField(
                                        autofocus: true,
                                        controller: reason,
                                        decoration: InputDecoration(
                                          label: const Text("Reson"),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              // color: Colors.black,
                                              width: 0.01,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CupertinoButton(
                                      // color: Colors.blueGrey,
                                      child: const Text("Confirm"),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("problemandcancel")
                                            .add({
                                          "cancel": true,
                                          "WhyCancel": reason.text,
                                        });
                                        FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc(widget.proId)
                                            .delete();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    CupertinoButton(
                      child: const Text("Contact Us"),
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                              "https://api.whatsapp.com/send/?phone=919380869058"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    CupertinoButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteComment(
                              productId: snapshot2.data!['product_id'],
                            ),
                          ),
                        );
                      },
                      child: const Text("Write a Review"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
