import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? userIn = FirebaseAuth.instance.currentUser;
widthis(context, size) {
  return MediaQuery.of(context).size.width * size;
}

heightof(context, size) {
  return MediaQuery.of(context).size.height * size;
}

// ignore: non_constant_identifier_names

TextEditingController nameOfVender = TextEditingController();
TextEditingController products = TextEditingController();
TextEditingController from = TextEditingController();

String profileLink = "";

fetchFunction() {
  FirebaseFirestore.instance
      .collection("sellers")
      .doc(userIn!.email)
      .get()
      .then((value) => {
            if (value['name'] != null)
              {
                nameOfVender.text = value['name'],
                products.text = value['products'],
                from.text = value['from'],
                profileLink = value['img'],
              }
            else
              {}
          })
      .catchError((error) {
    print(error);
  });
}

TextEditingController newsdes = TextEditingController();
String imglinkfornews = "";

TextEditingController imagnameN = TextEditingController();

TextEditingController rattingT = TextEditingController();

TextEditingController titleT = TextEditingController();

TextEditingController priceT = TextEditingController();
TextEditingController stockT = TextEditingController();
TextEditingController offertT = TextEditingController();
TextEditingController infoT = TextEditingController();
TextEditingController aboutT = TextEditingController();
TextEditingController ImgnameT = TextEditingController();
TextEditingController desT = TextEditingController();

var linkOfImage = [];
String selectedDesLink = "";

TextEditingController titleP = TextEditingController();
TextEditingController dealP = TextEditingController();
TextEditingController priceP = TextEditingController();
TextEditingController stockP = TextEditingController();
TextEditingController offerP = TextEditingController();
TextEditingController infoP = TextEditingController();
TextEditingController desP = TextEditingController();
TextEditingController keywordP = TextEditingController();

var offerL = [];
var infoL = [];
var desL = [];
var keywordL = [];
