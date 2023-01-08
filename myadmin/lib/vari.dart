import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

TextEditingController title = TextEditingController();
TextEditingController info = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController offer = TextEditingController();
TextEditingController deal = TextEditingController();
TextEditingController imglink = TextEditingController();
TextEditingController rattings = TextEditingController();
TextEditingController stock = TextEditingController();
TextEditingController about = TextEditingController();

addwidth(context, mywidth) {
  return MediaQuery.of(context).size.width * mywidth;
}

addHeight(context, myheight) {
  return MediaQuery.of(context).size.height * myheight;
}

pushTo(context, pagefun) {
  return Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => pagefun(),
    ),
  );
}

TextEditingController nextLoc = TextEditingController();

bool uploadContent = false;

String currentHistory = "";

TextEditingController amtPricelist = TextEditingController();
TextEditingController keywords = TextEditingController();
TextEditingController catogoryAdd = TextEditingController();
// ignore: unused_element

File? imgfile;

String downloadUrl = "";
var userKe = [];

String linkSelected = "";

TextEditingController rattingT = TextEditingController();

TextEditingController titleT = TextEditingController();

TextEditingController priceT = TextEditingController();

TextEditingController stockT = TextEditingController();

TextEditingController offertT = TextEditingController();

TextEditingController infoT = TextEditingController();

TextEditingController aboutT = TextEditingController();

TextEditingController desT = TextEditingController();
TextEditingController ImgnameT = TextEditingController();

String selectedDesLink = "";

var randSize = FirebaseFirestore.instance.collection("products").get();

var randomn = Random();

List<String> linkOfImage = [];

//product upload
TextEditingController priceP = TextEditingController();
TextEditingController updatekey = TextEditingController();
TextEditingController stockP = TextEditingController();
TextEditingController aboutP = TextEditingController();
TextEditingController infoP = TextEditingController();
TextEditingController offerP = TextEditingController();
TextEditingController desP = TextEditingController();
TextEditingController brefDesP = TextEditingController();
TextEditingController titleP = TextEditingController();
TextEditingController dealP = TextEditingController();
TextEditingController keywordP = TextEditingController();
TextEditingController imageNameP = TextEditingController();

final ImagePicker _picker = ImagePicker();

List<String> keywordL = [];
List<String> aboutL = [];
List<String> desL = [];
List<String> infoL = [];
List<String> offerL = [];

String selectedDesP = "";

TextEditingController newsdes = TextEditingController();
TextEditingController imagnameN = TextEditingController();
String imglinkfornews = "";
