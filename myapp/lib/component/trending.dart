import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/variables.dart';

class TrendingProduct extends StatefulWidget {
  const TrendingProduct({Key? key}) : super(key: key);

  @override
  State<TrendingProduct> createState() => _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.connectionState == ConnectionState.waiting ||
            !snapshot1.hasData ||
            snapshot1.hasError) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 96,
                height: 80,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.grey.withOpacity(0.5),
                ),
              );
            },
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot1.data!.docs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductView(
                      productId: snapshot1.data!.docs[index].id.toString(),
                    ),
                  ),
                ),
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: CachedNetworkImage(
                        imageUrl: snapshot1.data!.docs[index]["img"][0],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.01),
                      child: Text(
                        snapshot1.data!.docs[index]["title"],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "₹ ${snapshot1.data!.docs[index]["price"].toString()}",
                      style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      " ${snapshot1.data!.docs[index]["deal"].toString()} %",
                      style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
