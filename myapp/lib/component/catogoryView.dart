// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/product.dart';

import '../variables.dart';

// ignore: camel_case_types
class catogoryView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var keysw;
  catogoryView({Key? key, required this.keysw}) : super(key: key);

  @override
  State<catogoryView> createState() => _catogoryViewState();
}

// ignore: camel_case_types
class _catogoryViewState extends State<catogoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        leading: null,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where("keyword", arrayContainsAny: widget.keysw)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting ||
              snapshot1.hasError) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot1.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(
                        productId: snapshot1.data!.docs[index].id.toString(),
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
                          snapshot1.data!.docs[index]["img"][0],
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot1.data!.docs[index]['title'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "₹${snapshot1.data!.docs[index]['price'].toString()}",
                              style: const TextStyle(
                                fontSize: 15,
                                // color: Color.fromARGB(255, 0, 86, 3),
                              ),
                            ),
                            Text(
                              "${snapshot1.data!.docs[index]['deal'].toString()}%",
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
                                "⭐" * snapshot1.data!.docs[index]['rattings'],
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
