import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myapp/component/catogory.dart';
import 'package:myapp/component/priceList.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/component/seller.dart';
import 'package:myapp/component/suggetion.dart';
import 'package:myapp/component/trending.dart';
import 'package:myapp/variables.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: FirebaseFirestore.instance.collection("carouselSlider").get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  width: double.infinity,
                  height: heightof(context, 0.25),
                ),
              );
            }

            return CarouselSlider(
              items: [
                for (var item in snapshot.data!.docs)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductView(
                            productId: item['id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                          // color: const Color.fromARGB(92, 247, 244, 244),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            color: Colors.transparent,
                            height: heightof(context, 0.19),
                            child: CachedNetworkImage(
                              imageUrl: item['img'].toString(),
                              // progressIndicatorBuilder:
                              //     (context, url, downloadProgress) =>
                              //         const Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                            ),
                          ),
                          Text(
                            item['title'],
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  reverse: true,
                  onPageChanged: (index, reaon) {
                    setState(() {
                      sliderIndex = index;
                    });
                  }),
            );
          },
        ),
        CarouselIndicator(
          count: 6,
          index: sliderIndex,
          // color: Colors.white,
          // activeColor: Colors.black,
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(
            top: heightof(
              context,
              0.04,
            ),
            left: widthis(
              context,
              0.04,
            ),
          ),
          child: Text(
            "Categories",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 26,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            top: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: const Color.fromARGB(82, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CotogoryItem(),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(
            top: heightof(
              context,
              0.04,
            ),
            left: widthis(
              context,
              0.04,
            ),
          ),
          child: Text(
            "Top Sellers",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 26,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            top: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.04,
          ),
          decoration: BoxDecoration(
            // color: const Color.fromARGB(90, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.13,
          width: double.infinity,
          child: const SellersProfile(),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(
            top: heightof(
              context,
              0.04,
            ),
            left: widthis(
              context,
              0.04,
            ),
          ),
          child: Text(
            "Top Purchesed",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 26,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.04,
          ),
          decoration: BoxDecoration(
            // color: const Color.fromARGB(90, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.32,
          width: double.infinity,
          child: const TrendingProduct(),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(
            top: heightof(
              context,
              0.04,
            ),
            left: widthis(
              context,
              0.04,
            ),
          ),
          child: Text(
            "Budgets",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 26,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: const Color.fromARGB(82, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const PriceList(),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(
            top: heightof(
              context,
              0.04,
            ),
            left: widthis(
              context,
              0.04,
            ),
          ),
          child: Text(
            "Products",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.04,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: const Color.fromARGB(82, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Suggetions(),
        ),
      ],
    );
  }
}
