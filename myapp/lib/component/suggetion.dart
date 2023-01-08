import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/variables.dart';

class Suggetions extends StatefulWidget {
  const Suggetions({Key? key}) : super(key: key);

  @override
  State<Suggetions> createState() => _SuggetionsState();
}

class _SuggetionsState extends State<Suggetions> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.connectionState == ConnectionState.waiting ||
            !snapshot1.hasData ||
            snapshot1.hasError) {
          return Wrap(
            children: [
              for (var i = 0; i <= 10; i++)
                Container(
                  margin: EdgeInsets.only(
                    left: widthis(context, 0.02),
                    right: widthis(context, 0.02),
                    top: heightof(context, 0.02),
                  ),
                  padding: const EdgeInsets.all(5),
                  height: heightof(context, 0.22),
                  width: widthis(context, 0.39),
                ),
            ],
          );
        }
        return Wrap(
          children: [
            for (var i in snapshot1.data!.docs)
              GestureDetector(
                onTap: () {
                  AddToHistory(i.id.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(
                        productId: i.id.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: widthis(context, 0.02),
                    right: widthis(context, 0.02),
                    top: heightof(context, 0.02),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: const [],
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(5),
                  // height: heightof(context, 0.22),
                  width: widthis(context, 0.40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: heightof(context, 0.10),
                        width: widthis(context, 0.32),
                        child: CachedNetworkImage(
                          imageUrl: i["img"][0],
                        ),
                      ),
                      Text(
                        i["title"],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${i["deal"].toString()}% offer on this item",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "₹${i["price"].toString()}",
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 16,
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
        );
      },
    );
  }
}
