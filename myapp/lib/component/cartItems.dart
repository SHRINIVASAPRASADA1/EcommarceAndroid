import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/component/product.dart';
import 'package:myapp/component/selectAddress.dart';
import 'package:myapp/variables.dart';
// ignore: implementation_imports

class CartItems extends StatefulWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int cartItemCount = 0;
  int itemCount = 0;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("AllUser")
        .doc(userIn!.email)
        .collection("cart")
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                setState(() {
                  cartItemCount += int.parse(element['price'].toString());
                  itemCount += 1;
                });
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(200, 112, 44, 239),
          ),
      bottomNavigationBar: CupertinoButton(
        // color: const Color.fromARGB(151, 72, 47, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectAddress(
                amt: 24,
              ),
            ),
          );
          setState(() {
            totalCartAmt = cartItemCount;
          });
        },
        child: Text("$itemCount items Total $cartItemCount"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(userIn!.email)
            .collection("cart")
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting ||
              snapshot2.hasError) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (snapshot2.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Data Found !",
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot2.data!.docs.length,
            itemBuilder: (context, index) {
              products.add(snapshot2.data!.docs[index].id);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(
                        productId: snapshot2.data!.docs[index]['id'],
                      ),
                    ),
                  );
                },
                child: GestureDetector(
                  onHorizontalDragEnd: (details) => {
                    initState(),
                    FirebaseFirestore.instance
                        .collection("AllUser")
                        .doc(userIn!.email)
                        .collection("cart")
                        .doc(
                          snapshot2.data!.docs[index].id.toString(),
                        )
                        .delete(),
                  },
                  child: Container(
                    width: widthis(context, 0.90),
                    height: heightof(context, 0.18),
                    margin: const EdgeInsets.all(03),
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(218, 213, 215, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(03),
                          width: widthis(context, 0.22),
                          child: CachedNetworkImage(
                            imageUrl: snapshot2.data!.docs[index]['img'],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const CircularProgressIndicator(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                width: widthis(context, 0.70),
                                child: Text(
                                  snapshot2.data!.docs[index]['title'],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                      "₹ ${snapshot2.data!.docs[index]['price']}"),
                                ),
                                GestureDetector(
                                  onTap: (() => {
                                        FirebaseFirestore.instance
                                            .collection("AllUser")
                                            .doc(userIn!.email)
                                            .collection("cart")
                                            .doc(
                                              snapshot2.data!.docs[index].id
                                                  .toString(),
                                            )
                                            .delete(),
                                      }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: const Color.fromARGB(
                                      //     255, 245, 89, 78),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.centerRight,
                                    child: const Text("Remove"),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                snapshot2.data!.docs[index]['stock'].toString(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
