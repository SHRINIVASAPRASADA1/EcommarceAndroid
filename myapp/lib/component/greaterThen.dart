// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/variables.dart';

// ignore: must_be_immutable
class GreaterThenRange extends StatefulWidget {
  String amt = "";
  GreaterThenRange({Key? key, required this.amt}) : super(key: key);

  @override
  State<GreaterThenRange> createState() => _GreaterThenRangeState();
}

class _GreaterThenRangeState extends State<GreaterThenRange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: Text(
          "Products Under ${widget.amt} ",
          style: const TextStyle(
              // color: Colors.black,
              ),
        ),
        // backgroundColor: const Color.fromARGB(200, 112, 44, 239),
        // shadowColor: const Color.fromARGB(200, 112, 44, 239),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where(
              "price",
              isGreaterThanOrEqualTo: int.parse(widget.amt),
            )
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
          if (snapshot2.hasError) {
            return Text(snapshot2.hasError.toString());
          }
          if (!snapshot2.hasData) {
            return Text(snapshot2.hasError.toString());
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot2.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(
                        productId: snapshot2.data!.docs[index].id.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      // color: Color.fromARGB(218, 213, 215, 255),
                      ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        // color: Colors.white,
                        height: heightof(context, 0.15),
                        padding: const EdgeInsets.all(8),
                        width: widthis(context, 0.35),
                        child: Image.network(
                          snapshot2.data!.docs[index]["img"][0],
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        width: widthis(context, 0.59),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: widthis(context, 0.03),
                              ),
                              child: Text(
                                snapshot2.data!.docs[index]['title'],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: widthis(context, 0.02),
                                    right: widthis(context, 0.02),
                                  ),
                                  child: Text(
                                    "₹${snapshot2.data!.docs[index]['price'].toString()}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      // color: Color.fromARGB(255, 0, 86, 3),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    right: widthis(context, 0.02),
                                  ),
                                  child: Text(
                                    "${snapshot2.data!.docs[index]['deal'].toString()}%",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Colors.green,
                                  ),
                                  child: Text(
                                    "${snapshot2.data!.docs[index]['rattings'].toString()}⭐",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
