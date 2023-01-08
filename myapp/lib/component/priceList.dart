// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/component/greaterThen.dart';

import 'package:myapp/component/productUnder.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("priceList").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
        if (snapshot2.connectionState == ConnectionState.waiting ||
            !snapshot2.hasData ||
            snapshot2.hasError) {
          return Wrap(
            children: [
              for (var item = 0; item <= 14; item++)
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.width * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
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
                      builder: (context) => ProductUnderRange(
                        amt: item["price"].toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.10,
                  // decoration: BoxDecoration(
                  //   boxShadow: const [
                  //     BoxShadow(
                  //       color: Color.fromARGB(255, 218, 217, 217),
                  //       blurRadius: 3,
                  //     )
                  //   ],
                  //   borderRadius: BorderRadius.circular(02),
                  // ),
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.width * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Center(
                      child: Text(
                        "₹${item["price"]}",
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 26,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GreaterThenRange(
                      amt: "10000",
                    ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.10,
                // decoration: BoxDecoration(
                //   boxShadow: const [
                //     BoxShadow(
                //       color: Color.fromARGB(255, 202, 202, 202),
                //       blurRadius: 5,
                //     )
                //   ],
                //   borderRadius: BorderRadius.circular(02),
                // ),
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Card(
                  elevation: 0.4,
                  // color: const Color.fromARGB(236, 255, 255, 255),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: const Center(
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
