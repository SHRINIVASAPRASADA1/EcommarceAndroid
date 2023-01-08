// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/home/Delivery.dart';
import 'package:myadmin/home/PriceListUpdate.dart';
import 'package:myadmin/home/Products.dart';
import 'package:myadmin/home/UpdateCarousel.dart';
import 'package:myadmin/home/UpdateCatogory.dart';
import 'package:myadmin/home/addnews.dart';
import 'package:myadmin/home/uploadProduct.dart';
import 'package:myadmin/home/users.dart';
import 'package:myadmin/home/vendorNewsReq.dart';
import 'package:myadmin/home/vendorProductReq.dart';
import 'package:myadmin/home/vendors.dart';
import 'package:myadmin/vari.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Admin"),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorsOnEcom(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Text("Vendors")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageUser(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Text("Users")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateCaroselSlider(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.view_carousel,
                      size: 100,
                    ),
                    Text("Carousel slider")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const DeliveryUpdate(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.delivery_dining,
                      size: 100,
                    ),
                    Text("Delivery")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const PriceListUpdate(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.price_change,
                      size: 100,
                    ),
                    Text("Update Price")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UpdateCatogory(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.category,
                      size: 100,
                    ),
                    Text("Catogory")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const VendorProductReq(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.add_card,
                      size: 100,
                    ),
                    Text("Vendor Request")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AllProducts(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.edit,
                      size: 100,
                    ),
                    Text("Products Edit")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UploadNewProduct(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.plus_one,
                      size: 100,
                    ),
                    Text("Add Product")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddNews(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.newspaper,
                      size: 100,
                    ),
                    Text("Add News")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const VendorNewsReq(),
                  ),
                );
              },
              child: Container(
                width: addwidth(context, 0.44),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(195, 0, 0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.newspaper_rounded,
                      size: 100,
                    ),
                    Text("News Upload Req")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
