import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../variables.dart';

// ignore: non_constant_identifier_names
AddAddress(BuildContext context) {
  return showBarModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(7),
              padding: const EdgeInsets.all(10),
              height: heightof(context, 0.01),
              width: widthis(context, 0.20),
              decoration: BoxDecoration(
                // color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
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
                  hintText: "Enter Area ,Street Or ,Post ,villeage",
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
                    .add({
                  "name": name.text,
                  "street": street.text,
                  "areaNear": NearArea.text,
                  "mobileNumber": number.text,
                  "state": state.text,
                  "city": city.text,
                  "pincode": pin.text,
                });
              },
            ),
          ],
        ),
      );
    },
  );
}
