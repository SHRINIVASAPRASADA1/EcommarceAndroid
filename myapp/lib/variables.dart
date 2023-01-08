// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;

String vendorId = "";

TextEditingController comment = TextEditingController();

widthis(context, size) {
  return MediaQuery.of(context).size.width * size;
}

heightof(context, size) {
  return MediaQuery.of(context).size.height * size;
}

TextEditingController search = TextEditingController();

String searchdata = "product";

User? userIn = FirebaseAuth.instance.currentUser;

int sliderIndex = 0;

TextEditingController street = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController pin = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController state = TextEditingController();
TextEditingController number = TextEditingController();
// ignore: non_constant_identifier_names
TextEditingController NearArea = TextEditingController();

String UserSelectedBuyItem = "";

// int cartItemCount = 0;

int totalCartAmt = 0;
String selectedAddress = "";

addTax(int amt) {
  return amt + ((amt * 15) / 100);
}

addOffer(double amt) {
  return amt - ((amt * 10) / 100);
}

String selectedPayment = "pay";

var products = [];
confirmOrder(address, product_id, payment_status) {
  FirebaseFirestore.instance.collection("orders").add({
    "address": address,
    "product_id": product_id,
    "date": DateTime.now(),
    "payment_status": payment_status,
    "state": [
      "banglore",
    ]
  });
}

var dataaa = {
  "hii": "sdasjh",
};

AddToHistory(product) {
  FirebaseFirestore.instance
      .collection("AllUser")
      .doc(userIn!.email)
      .collection("history")
      .add({
    "productId": product,
    "date": DateTime.now(),
  });
}

Brightness setBrightness = Brightness.dark;

bool darkModeOn = true;

Color appbar = Colors.black;

String test = "";

int productViewIndex = 0;

// bool darkMode = true;
