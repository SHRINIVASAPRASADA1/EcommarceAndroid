import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:myapp/component/cusromCompont.dart';
import 'package:myapp/variables.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(200, 112, 44, 239),
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
            return Center(
              child: Container(
                child: Lottie.asset(
                  "assets/loti/progress.json",
                  repeat: true,
                  reverse: true,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Wrap(
              children: [
                for (var item in snapshot2.data!.docs)
                  Dismissible(
                    key: Key(item.id.toString()),
                    onDismissed: (data) {
                      FirebaseFirestore.instance
                          .collection("AllUser")
                          .doc(userIn!.email.toString())
                          .collection("address")
                          .doc(item.id)
                          .delete();
                    },
                    child: GestureDetector(
                      onTap: () {
                        name.text = item['name'];
                        street.text = item['street'];
                        pin.text = item['pincode'];
                        number.text = item['mobileNumber'];
                        city.text = item['city'];
                        NearArea.text = item['areaNear'];
                        state.text = item['state'];

                        showBarModalBottomSheet(
                          expand: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // backgroundColor:
                          // const Color.fromARGB(238, 253, 254, 254),
                          context: context,
                          builder: (BuildContext context) {
                            return Scrollbar(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: name,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name ",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: street,
                                      decoration: const InputDecoration(
                                        hintText:
                                            "Enter Area ,Street Or ,Post ,villeage",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: city,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your city !",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: state,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your State",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: number,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your Mobile Number ",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: pin,
                                      decoration: const InputDecoration(
                                        hintText: "Enter PinCode Of your city",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: widthis(context, 0.02),
                                      right: widthis(context, 0.02),
                                      top: heightof(context, 0.02),
                                    ),
                                    child: TextField(
                                      controller: NearArea,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your nearest Area ",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: const Text("Add Address"),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("AllUser")
                                          .doc(userIn!.email.toString())
                                          .collection("address")
                                          .doc(item.id.toString())
                                          .update({
                                        "name": name.text,
                                        "street": street.text,
                                        "areaNear": NearArea.text,
                                        "mobileNumber": number.text,
                                        "state": state.text,
                                        "city": city.text,
                                        "pincode": pin.text,
                                      });
                                      name.text = "";
                                      street.text = "";
                                      pin.text = "";
                                      number.text = "";
                                      city.text = "";
                                      NearArea.text = "";
                                      state.text = "";
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            width: 0.02,
                            // color: Colors.black,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              // color: Color.fromARGB(255, 219, 214, 214),
                              offset: Offset(0.1, 0.1),
                              blurRadius: 2.0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['state'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['city'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['pincode'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['areaNear'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['mobileNumber'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                            Text(
                              item['street'],
                              style: const TextStyle(shadows: [
                                Shadow(
                                  // color: Color.fromARGB(140, 0, 0, 0),
                                  blurRadius: 2.0,
                                  offset: Offset(1.0, 1.0),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CupertinoButton(
        // color: const Color.fromARGB(200, 112, 44, 239),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            Text("Add Address"),
          ],
        ),
        onPressed: () {
          AddAddress(context);
        },
      ),
    );
  }
}
