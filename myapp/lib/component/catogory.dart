import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/component/catogoryView.dart';
import 'package:myapp/variables.dart';

class CotogoryItem extends StatefulWidget {
  const CotogoryItem({Key? key}) : super(key: key);

  @override
  State<CotogoryItem> createState() => _CotogoryItemState();
}

class _CotogoryItemState extends State<CotogoryItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("catogory").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
        if (snapshot2.connectionState == ConnectionState.waiting ||
            !snapshot2.hasData ||
            snapshot2.hasError) {
          return Wrap(
            children: [
              for (var item = 0; item <= 10; item++)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.width * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: heightof(context, 0.10),
                ),
            ],
          );
        }
        return Wrap(
          children: [
            for (var item in snapshot2.data!.docs)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => catogoryView(
                        keysw: item["keyword"],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Color.fromARGB(255, 255, 253, 253),
                    //     blurRadius: 2,
                    //   )
                    // ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.width * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: CachedNetworkImage(
                            imageUrl: item["logo"],
                          )),
                      Text(
                        item["name"],
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.normal,
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
