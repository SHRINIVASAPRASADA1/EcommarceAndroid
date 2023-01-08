// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/component/trackDelivery.dart';
import 'package:myapp/variables.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightof(context, 1),
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("orders")
            .where("buyer", isEqualTo: userIn!.email.toString())
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting ||
              snapshot1.hasError) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (snapshot1.data!.docs.isEmpty) {
            return Lottie.network(
                "https://assets1.lottiefiles.com/private_files/lf30_e3pteeho.json");
          }
          return ListView.builder(
            itemCount: snapshot1.data!.docs.length,
            itemBuilder: (context, index) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .doc(snapshot1.data!.docs[index]['product_id'].toString())
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting ||
                      snapshot2.hasError) {
                    return ListView.builder(
                      shrinkWrap: true,
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
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackMyOrder(
                            proId: snapshot1.data!.docs[index].id.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 255, 252, 252),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.01,
                          // color: Colors.black,
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      width: widthis(context, 1.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widthis(context, 0.30),
                            height: heightof(context, 0.15),
                            child: Image.network(
                              snapshot2.data!['img'][0].toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widthis(context, 0.57),
                                child: Text(
                                  snapshot2.data!['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      // color: Colors.black,
                                      shadows: [
                                        Shadow(
                                          // color: Color.fromARGB(255, 0, 0, 0),
                                          // blurRadius: 2.0,
                                          offset: Offset(1.0, 1.0),
                                        )
                                      ]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: widthis(context, 0.040),
                                      left: widthis(context, 0.040),
                                    ),
                                    // child: Text(
                                    //   "${snapshot2.data!['stock'].toString()} stock Left!",
                                    //   textAlign: TextAlign.center,
                                    // ),
                                  ),
                                  // Text(
                                  //   "${snapshot2.data!['rattings'].toString()}⭐",
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 0.2,
                                  // color: const Color.fromARGB(255, 0, 65, 193),
                                )),
                                child: Text(snapshot1.data!.docs[index]['state']
                                    [snapshot1
                                            .data!.docs[index]['state'].length -
                                        1]),
                              ),
                            ],
                          )
                        ],
                      ),
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
