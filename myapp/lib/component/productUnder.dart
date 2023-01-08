// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/variables.dart';

// ignore: must_be_immutable
class ProductUnderRange extends StatefulWidget {
  String amt = "";
  ProductUnderRange({Key? key, required this.amt}) : super(key: key);

  @override
  State<ProductUnderRange> createState() => _ProductUnderRangeState();
}

class _ProductUnderRangeState extends State<ProductUnderRange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.black),
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
              isLessThanOrEqualTo: int.parse(widget.amt),
              isGreaterThanOrEqualTo: int.parse(widget.amt) - 200,
            )
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting ||
              snapshot2.hasError) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  height: 80,
                  width: double.infinity,
                );
              },
            );
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
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(218, 213, 215, 255),
                    border: Border.all(
                      width: 0.2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        // color: Colors.white,
                        height: heightof(context, 0.12),
                        padding: const EdgeInsets.all(8),
                        width: widthis(context, 0.30),
                        child: Image.network(
                          snapshot2.data!.docs[index]["img"][0],
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot2.data!.docs[index]['title'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "₹${snapshot2.data!.docs[index]['price'].toString()}",
                              style: const TextStyle(
                                fontSize: 15,
                                // color: Color.fromARGB(255, 0, 86, 3),
                              ),
                            ),
                            Text(
                              "${snapshot2.data!.docs[index]['deal'].toString()}%",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2, right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: Colors.green,
                              ),
                              child: Text(
                                "⭐" * snapshot2.data!.docs[index]['rattings'],
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
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
