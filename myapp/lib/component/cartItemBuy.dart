import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myapp/component/paymentSeccess.dart';
import 'package:myapp/variables.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartItemBuy extends StatefulWidget {
  const CartItemBuy({Key? key}) : super(key: key);

  @override
  State<CartItemBuy> createState() => _CartItemBuyState();
}

class _CartItemBuyState extends State<CartItemBuy> {
  final _razorpay = Razorpay();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance
        .collection("AllUser")
        .doc(userIn!.email)
        .collection("cart")
        .get()
        .then((value) => {
              // ignore: avoid_function_literals_in_foreach_calls
              value.docs.forEach((element) {
                setState(() {
                  FirebaseFirestore.instance.collection("orders").add({
                    "address": selectedAddress.toString(),
                    "product_id": element['id'].toString(),
                    "date": DateTime.now(),
                    "buyer": userIn!.email.toString(),
                    "payment_status": true,
                    "state": [
                      "banglore",
                    ],
                    "cancel": false,
                    "vendor": element['vendor'].toString(),
                  });
                });
              })
            });
    FirebaseFirestore.instance
        .collection("AllUser")
        .doc(userIn!.email)
        .collection("cart")
        .get()
        .then((value) => {
              // ignore: list_remove_unrelated_type
              for (var item in value.docs)
                {
                  item.reference.delete(),
                }
            });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentSeccess(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products[0]),
        // backgroundColor: const Color.fromARGB(151, 72, 47, 240),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: heightof(context, 0.35),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("AllUser")
                    .doc(userIn!.email)
                    .collection("cart")
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          // backgroundColor: Colors.purple,
                          ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot1.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: heightof(context, 0.35),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // color: const Color.fromARGB(99, 118, 205, 245),
                            borderRadius: BorderRadius.circular(7)),
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: heightof(context, 0.20),
                              width: widthis(context, 0.30),
                              child: CachedNetworkImage(
                                imageUrl: snapshot1.data!.docs[index]['img']
                                    .toString(),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              width: widthis(context, 0.30),
                              child: Text(
                                snapshot1.data!.docs[index]['title'],
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Text(snapshot1.data!.docs[index]['price']
                                .toString()),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: const Color.fromARGB(85, 255, 153, 0),
                border: Border.all(
                  width: 0.01,
                  // color: Colors.black,
                ),
              ),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("AllUser")
                    .doc(userIn!.email)
                    .collection("address")
                    .doc(selectedAddress.toString())
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
                  if (!snapshot1.hasData ||
                      snapshot1.hasError ||
                      snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot1.data!['name']),
                      Text(
                        snapshot1.data!['state'],
                      ),
                      Text(
                        snapshot1.data!['city'],
                      ),
                      Text(
                        snapshot1.data!['street'],
                      ),
                      Text(
                        snapshot1.data!['areaNear'],
                      ),
                      Text(
                        snapshot1.data!['pincode'],
                      ),
                      Text(
                        snapshot1.data!['mobileNumber'],
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: widthis(context, 0.10),
                right: widthis(context, 0.10),
                bottom: widthis(context, 0.03),
                top: widthis(context, 0.03),
              ),
              width: double.infinity,
              // color: Colors.black,
              height: heightof(context, 0.001),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Current Amount :"),
                    Text(totalCartAmt.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text("GST :"),
                    Text("+10%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text("CGST :"),
                    Text("+5%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Delivery Charge :"),
                    Text(totalCartAmt >= 500 ? "free Delivery" : "40Rs"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("MRP :"),
                    Text(addTax(totalCartAmt).toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Offer Applied  :"),
                    Text(addOffer(addTax(totalCartAmt)).toString()),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: widthis(context, 0.10),
                top: widthis(context, 0.03),
                right: widthis(context, 0.10),
                bottom: widthis(context, 0.02),
              ),
              width: double.infinity,
              // color: Colors.black,
              height: heightof(context, 0.001),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Payable Amount ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  addOffer(addTax(totalCartAmt)).toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: widthis(context, 0.10),
                top: widthis(context, 0.03),
                right: widthis(context, 0.10),
                bottom: widthis(context, 0.02),
              ),
              width: double.infinity,
              // color: Colors.black,
              height: heightof(context, 0.001),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(
                top: heightof(context, 0.05),
                left: widthis(context, 0.05),
              ),
              child: const Text(
                "Select Payment Option",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Radio(
                autofocus: true,
                value: "cod",
                groupValue: selectedPayment,
                onChanged: (val) {
                  setState(() {
                    selectedPayment = val.toString();
                  });
                },
              ),
              title: const Text("Cash On delivery"),
            ),
            ListTile(
              leading: Radio(
                autofocus: false,
                value: "pay",
                groupValue: selectedPayment,
                onChanged: (val) {
                  setState(() {
                    selectedPayment = val.toString();
                  });
                },
              ),
              title: const Text("Online Payments.."),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoButton(
        // color: Colors.green,
        child: const Text("Pay Now"),
        onPressed: () async {
          var options = {
            'key': 'rzp_test_HPR933L2nTKRBP',
            'amount': 50000 * 100, //in the smallest currency sub-unit.
            'name': 'shrinivasaprasada',
            // 'order_id':
            //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
            'description': 'saree',
            'timeout': 500, // in seconds
            'prefill': {
              'contact': '9380869058',
              'email': 'shrinivasagowdagowda@gmail.com'
            }
          };
          _razorpay.open(options);
          if (selectedPayment == "pay") {
          } else {
            FirebaseFirestore.instance
                .collection("AllUser")
                .doc(userIn!.email)
                .collection("cart")
                .get()
                .then((value) => {
                      // ignore: avoid_function_literals_in_foreach_calls
                      value.docs.forEach((element) {
                        setState(() {
                          FirebaseFirestore.instance.collection("orders").add({
                            "address": selectedAddress.toString(),
                            "product_id": element['id'].toString(),
                            "date": DateTime.now(),
                            "buyer": userIn!.email.toString(),
                            "payment_status": false,
                            "state": [
                              "confirmed  ✅",
                            ],
                            "cancel": false,
                            "vendor": element['vendor'].toString()
                          });
                        });
                      })
                    });
            FirebaseFirestore.instance
                .collection("AllUser")
                .doc(userIn!.email)
                .collection("cart")
                .get()
                .then((value) => {
                      // ignore: list_remove_unrelated_type
                      for (var item in value.docs)
                        {
                          item.reference.delete(),
                        }
                    });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentSeccess(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
