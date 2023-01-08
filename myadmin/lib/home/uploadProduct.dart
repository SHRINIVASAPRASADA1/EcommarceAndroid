import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myadmin/home/Products.dart';
import 'package:myadmin/home/UpdateCatogory.dart';
import 'package:myadmin/vari.dart';

class UploadNewProduct extends StatefulWidget {
  const UploadNewProduct({Key? key}) : super(key: key);

  @override
  State<UploadNewProduct> createState() => _UploadNewProductState();
}

class _UploadNewProductState extends State<UploadNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
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
                      linkOfImage.add(await uploadImageToFirebase(
                          myfile, DateTime.now().toString()) as String);
                    });
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.add,
                  size: 80,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: addHeight(context, 0.40),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: linkOfImage.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      linkOfImage[index],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: titleP,
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //offer
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: dealP,
                decoration: const InputDecoration(
                  labelText: "Offer",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //price
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: priceP,
                decoration: const InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //stock
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: stockP,
                decoration: const InputDecoration(
                  labelText: "Stock",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //offer List
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: offerP,
                decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      offerL.add(offerP.text);
                      offerP.text = "";
                    },
                    child: const Icon(Icons.add),
                  ),
                  labelText: "Enter List Of Offer",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            //info LIst
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: infoP,
                decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      infoL.add(infoP.text);
                      infoP.text = "";
                    },
                    child: const Icon(Icons.add),
                  ),
                  labelText: "Enter List Of Info",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            //about
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: desP,
                decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      desL.add(desP.text);
                      desP.text = "";
                    },
                    child: const Icon(Icons.add),
                  ),
                  labelText: "Enter List Of Product data",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            //keyword
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: keywordP,
                decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      keywordL.add(keywordP.text);
                      keywordP.text = "";
                    },
                    child: const Icon(Icons.add),
                  ),
                  labelText: "Enter Keywords",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("products").add({
            "about": aboutL,
            "deal": int.parse(dealP.text),
            "img": linkOfImage,
            "info": infoL,
            "keyword": keywordL,
            "offer": offerL,
            "price": int.parse(priceP.text),
            "stock": int.parse(stockP.text),
            "title": titleP.text,
            "vendor": "s8KEVPY4AR7dTyIldGha",
            "rattings": int.parse(2.toString()),
          });
          aboutL.clear();
          keywordL.clear();
          offerL.clear();
          titleP.text = "";
          dealP.text = "";
          priceP.text = "";
          infoL.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AllProducts(),
            ),
          );
        },
        child: const Icon(
          Icons.send,
        ),
      ),
    );
  }
}
