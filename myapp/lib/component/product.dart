import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/component/billing.dart';
import 'package:myapp/component/cartItems.dart';
import 'package:myapp/component/fullImageView.dart';
import 'package:myapp/component/writeComment.dart';
import 'package:myapp/variables.dart';

// ignore: must_be_immutable
class ProductView extends StatefulWidget {
  String productId = "";
  ProductView({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductAllState();
}

class _ProductAllState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("products")
          .doc(widget.productId.toString())
          .get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                widget.productId.toString(),
                style: const TextStyle(),
              ),
              iconTheme: const IconThemeData(),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        for (var i = 0; i <= 10; i++)
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: heightof(context, 0.25),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                      ],
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        reverse: true,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.5),
                        // color: const Color.fromARGB(101, 3, 246, 11),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(2),
                    ),
                    Container(
                      color: Colors.grey.withOpacity(0.5),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      height: 75,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: 80,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: 120,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: 300,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      width: double.infinity,
                      height: heightof(context, 0.05),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            iconTheme: const IconThemeData(),
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
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: CarouselIndicator(
                        count: 6,
                        index: 2,
                        // color: Colors.white,
                        // activeColor: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: const Color.fromARGB(101, 3, 246, 11),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "⭐" * snapshot.data!["rattings"],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
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
                  Container(
                    margin: const EdgeInsets.all(6),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₹ ${snapshot.data!["price"].toString()}",
                      style: GoogleFonts.arimo(fontSize: 22),
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
                        Container(
                          padding: const EdgeInsets.all(4),
                          color: const Color.fromARGB(22, 255, 255, 255),
                          margin: EdgeInsets.only(
                            left: widthis(
                              context,
                              0.1,
                            ),
                            top: heightof(
                              context,
                              0.01,
                            ),
                            right: widthis(
                              context,
                              0.02,
                            ),
                          ),
                          child: Text(
                            " • ${item.toString()}",
                            style: GoogleFonts.padauk(),
                          ),
                        ),
                    ],
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
                        Container(
                          padding: const EdgeInsets.all(4),
                          color: const Color.fromARGB(22, 255, 255, 255),
                          margin: EdgeInsets.only(
                            left: widthis(
                              context,
                              0.1,
                            ),
                            top: heightof(
                              context,
                              0.01,
                            ),
                            right: widthis(
                              context,
                              0.02,
                            ),
                          ),
                          child: Text(
                            item.toString(),
                            style: GoogleFonts.padauk(),
                          ),
                        ),
                    ],
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
                        Container(
                          padding: const EdgeInsets.all(4),
                          color: const Color.fromARGB(22, 255, 255, 255),
                          margin: EdgeInsets.only(
                            left: widthis(
                              context,
                              0.1,
                            ),
                            top: heightof(
                              context,
                              0.01,
                            ),
                            right: widthis(
                              context,
                              0.02,
                            ),
                          ),
                          child: Text(
                            item.toString(),
                            style: GoogleFonts.padauk(),
                          ),
                        )
                    ],
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
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("products")
                        .doc(widget.productId.toString())
                        .collection("description")
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot1) {
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
                          return Column(
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
                          );
                        },
                      );
                    },
                  ),
                  // Container(
                  //   alignment: Alignment.topRight,
                  //   padding: const EdgeInsets.all(5),
                  //   margin: EdgeInsets.only(
                  //     right: MediaQuery.of(context).size.width * 0.04,
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => WriteComment(
                  //             productId: widget.productId.toString(),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     icon: const Icon(
                  //       Icons.comment,
                  //     ),
                  //   ),
                  // ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("products")
                        .doc(widget.productId.toString())
                        .collection("comment")
                        .orderBy("date", descending: true)
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
                            child: ListTile(
                              leading: Image.asset("assets/img/profile.png"),
                              title:
                                  Text(snapshot2.data!.docs[index]["userName"]),
                              subtitle:
                                  Text(snapshot2.data!.docs[index]["comment"]),
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
          bottomNavigationBar: SizedBox(
              width: widthis(context, 1),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (() => {
                          FirebaseFirestore.instance
                              .collection("AllUser")
                              .doc(userIn!.email)
                              .collection("cart")
                              .add({
                            "img": snapshot.data!['img'][0].toString(),
                            "price": snapshot.data!['price'].toString(),
                            "stock": snapshot.data!['stock'].toString(),
                            "title": snapshot.data!['title'].toString(),
                            "id": widget.productId.toString(),
                            "vendor": snapshot.data!['vendor'].toString(),
                          }),
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const CartItems(),
                            ),
                          ),
                        }),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: widthis(context, 0.01),
                      ),
                      height: heightof(context, 0.06),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(155, 44, 62, 255),
                      ),
                      width: widthis(context, 0.49),
                      child: const Center(
                        child: Text("AddToCart"),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BillingOnItem(),
                        ),
                      );
                      setState(
                        () {
                          UserSelectedBuyItem = widget.productId.toString();
                          vendorId = snapshot.data!['vendor'].toString();
                        },
                      );
                    },
                    child: Container(
                      height: heightof(context, 0.06),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(152, 255, 153, 0),
                      ),
                      width: widthis(context, 0.50),
                      child: const Center(
                        child: Text("Buy Now"),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  // // ignore: non_constant_identifier_names
  // CommentComponent(user, comments) {
  //   return Row(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(2),
  //         margin: EdgeInsets.only(
  //           left: MediaQuery.of(context).size.width * 0.03,
  //           top: MediaQuery.of(context).size.width * 0.01,
  //           right: MediaQuery.of(context).size.width * 0.03,
  //         ),
  //         width: MediaQuery.of(context).size.width * 0.11,
  //         decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(40),
  //         ),
  //         child: Image.network(
  //           "https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png",
  //         ),
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             alignment: Alignment.topLeft,
  //             child: Text(
  //               user.toString(),
  //               textAlign: TextAlign.left,
  //               style: const TextStyle(
  //                 fontSize: 17,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.70,
  //             margin: EdgeInsets.only(
  //               left: MediaQuery.of(context).size.width * 0.01,
  //             ),
  //             child: Text(
  //               comments.toString(),
  //               textAlign: TextAlign.left,
  //               style: const TextStyle(
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
