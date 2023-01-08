// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myadmin/home/FullImageView.dart';
import 'package:myadmin/home/UpdateCatogory.dart';
import 'package:myadmin/vari.dart';

class EditVendorProduct extends StatefulWidget {
  String product_id = "";
  EditVendorProduct({Key? key, required this.product_id}) : super(key: key);

  @override
  State<EditVendorProduct> createState() => _EditVendorProductState();
}

class _EditVendorProductState extends State<EditVendorProduct> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("newUploadRequest")
          .doc(widget.product_id)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            actions: [],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: [
                      for (var item in snapshot.data!["img"])
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImageView(
                                  imglink: item.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Image.network(
                              item.toString(),
                            ),
                          ),
                        ),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      reverse: true,
                      onPageChanged: (index, reason) {},
                    ),
                  ),

                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: const Color.fromARGB(101, 3, 246, 11),
                      ),
                      alignment: Alignment.centerLeft,
                      child: snapshot.data!['rattings'] == ""
                          ? const Text("No rattings")
                          : Text(
                              "⭐" * snapshot.data!["rattings"],
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                    ),
                  ),
                  //txtox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: rattingT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "rattings",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "rattings": int.parse(rattingT.text),
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      snapshot.data!["title"],
                      style: GoogleFonts.arimo(),
                    ),
                  ),

                  //txtbox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: titleT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "title",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "title": titleT.text,
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₹ ${snapshot.data!["price"].toString()}",
                      style: GoogleFonts.arimo(fontSize: 22),
                    ),
                  ),
                  //txtbox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: priceT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Price",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "price": int.parse(priceT.text),
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(7),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Only ${snapshot.data!["stock"].toString()} stock left !",
                      style: GoogleFonts.arimo(),
                    ),
                  ),
                  //txtbox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: stockT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Number Of stock",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "stock": int.parse(stockT.text),
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(7),
                    child: Text(
                      " Best Offer's On the Day !",
                      style: GoogleFonts.arimo(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in snapshot.data!["offer"])
                        Dismissible(
                          key: Key(item.toString()),
                          onDismissed: (data) {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "offer": FieldValue.arrayRemove([item.toString()])
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: const Color.fromARGB(22, 255, 255, 255),
                            margin: EdgeInsets.only(
                              left: addHeight(
                                context,
                                0.1,
                              ),
                              top: addHeight(
                                context,
                                0.01,
                              ),
                              right: addwidth(
                                context,
                                0.02,
                              ),
                            ),
                            child: Text(
                              " • ${item.toString()}",
                              style: GoogleFonts.padauk(),
                            ),
                          ),
                        ),
                    ],
                  ),
                  //txtBox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: offertT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Add Offer",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "offer": FieldValue.arrayUnion([offertT.text])
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      " Product Information.",
                      style: GoogleFonts.arimo(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in snapshot.data!["info"])
                        Dismissible(
                          key: Key(item.toString()),
                          onDismissed: (data) {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "info": FieldValue.arrayRemove([item.toString()]),
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: const Color.fromARGB(22, 255, 255, 255),
                            margin: EdgeInsets.only(
                              left: addwidth(
                                context,
                                0.1,
                              ),
                              top: addHeight(
                                context,
                                0.01,
                              ),
                              right: addwidth(
                                context,
                                0.02,
                              ),
                            ),
                            child: Text(
                              item.toString(),
                              style: GoogleFonts.padauk(),
                            ),
                          ),
                        ),
                    ],
                  ),
                  //txtBox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: infoT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Add Other Info",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "info": FieldValue.arrayUnion([infoT.text]),
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      " About Product ",
                      style: GoogleFonts.arimo(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in snapshot.data!["about"])
                        Dismissible(
                          key: Key(item.toString()),
                          onDismissed: (data) {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "about":
                                  FieldValue.arrayRemove([item.toString()]),
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: const Color.fromARGB(22, 255, 255, 255),
                            margin: EdgeInsets.only(
                              left: addwidth(
                                context,
                                0.1,
                              ),
                              top: addHeight(
                                context,
                                0.01,
                              ),
                              right: addwidth(
                                context,
                                0.02,
                              ),
                            ),
                            child: Text(
                              item.toString(),
                              style: GoogleFonts.padauk(),
                            ),
                          ),
                        )
                    ],
                  ),
                  //txtbox
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: aboutT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Add Another About",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .update({
                              "about": FieldValue.arrayUnion([aboutT.text]),
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Text(
                      "In Details...",
                      style: GoogleFonts.arimo(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("newUploadRequest")
                        .doc(widget.product_id.toString())
                        .collection("description")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot1) {
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(snapshot1.data!.docs[index].id),
                            onUpdate: (data) {
                              FirebaseFirestore.instance
                                  .collection("newUploadRequest")
                                  .doc(widget.product_id.toString())
                                  .collection("description")
                                  .doc(snapshot1.data!.docs[index].id)
                                  .delete();
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(2),
                                  width: double.infinity,
                                  child: Image.network(
                                    snapshot1.data!.docs[index]["img"],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(2),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    snapshot1.data!.docs[index]["des"],
                                    style: GoogleFonts.montserrat(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: ImgnameT,
                      decoration: InputDecoration(
                        labelText: "Enter ImageName",
                        suffix: GestureDetector(
                          onTap: () async {
                            setState(
                              () async {
                                final ImagePicker _picker = ImagePicker();
                                setState(() async {
                                  XFile? image = (await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70,
                                  ));
                                  File myfile = File(image!.path);
                                  selectedDesLink =
                                      (await uploadImageToFirebase(
                                              myfile, DateTime.now().toString())
                                          as String);
                                });
                              },
                            );
                          },
                          child: const Icon(
                            Icons.upload,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(selectedDesLink),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: desT,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Description",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("newUploadRequest")
                                .doc(widget.product_id)
                                .collection("description")
                                .add({
                              "des": desT.text,
                              "img": selectedDesLink,
                            });
                            setState(() {
                              selectedDesLink = "";
                              desT.text = "";
                              ImgnameT.text = "";
                            });
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("newUploadRequest")
                        .doc(widget.product_id.toString())
                        .collection("comment")
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot2.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(25, 236, 224, 224)
                                // color: const Color.fromARGB(13, 0, 0, 0),
                                ),
                            child: Dismissible(
                              key: Key(
                                  snapshot2.data!.docs[index].id.toString()),
                              onDismissed: (data) {
                                FirebaseFirestore.instance
                                    .collection("newUploadRequest")
                                    .doc(widget.product_id.toString())
                                    .collection("comment")
                                    .doc(snapshot2.data!.docs[index].id)
                                    .delete();
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot2.data!.docs[index]["userName"],
                                ),
                                subtitle: Text(
                                  snapshot2.data!.docs[index]["comment"],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
