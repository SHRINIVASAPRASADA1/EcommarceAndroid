// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/component/paymentSeccess.dart';

import 'package:myapp/variables.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  String addId = "";
  PaymentPage({Key? key, required this.addId}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance.collection("orders").add({
      "address": widget.addId.toString(),
      "product_id": UserSelectedBuyItem.toString(),
      "date": DateTime.now(),
      "buyer": userIn!.email.toString(),
      "paid": true,
      "state": [
        "confirmed  ✅",
      ],
      "cancel": false,
      "vendor": vendorId,
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

  int rs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(UserSelectedBuyItem.toString())
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting ||
                      snapshot2.hasError) {
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
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
                      ),
                    );
                  }
                  rs = ((snapshot2.data!['price'] -
                              (snapshot2.data!['price'] /
                                  int.parse(
                                      snapshot2.data!['deal'].toString()))) +
                          (snapshot2.data!['price'] / 15) +
                          40)
                      .toInt();

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          height: heightof(context, 0.30),
                          child: Image.network(
                            snapshot2.data!['img'][0],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            snapshot2.data!['title'],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          // color: Colors.black,
                          height: heightof(context, 0.002),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              " The Main Price Of The Product",
                            ),
                            Text(
                              " ₹ ${snapshot2.data!['price'].toString()}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Todays Offer On This Product",
                            ),
                            Text(
                              "-${snapshot2.data!['deal'].toString()}%",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "The Gst Added On the Product",
                            ),
                            Text(
                              "+ 10%",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "CGST Added On The Product ",
                            ),
                            Text(
                              "+ 5%",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Delivery Charge",
                            ),
                            Text(
                              "              + 40",
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          // color: Colors.black,
                          height: heightof(context, 0.002),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Total Amount To Be Payable ",
                            ),
                            Text(
                              "₹ ${((snapshot2.data!['price'] - (snapshot2.data!['price'] / int.parse(snapshot2.data!['deal'].toString()))) + (snapshot2.data!['price'] / 15) + 40).toInt()}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          // color: Colors.black,
                          height: heightof(context, 0.002),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "Deliver To :",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("AllUser")
                    .doc(userIn!.email.toString())
                    .collection("address")
                    .doc(widget.addId.toString())
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshotAdd) {
                  if (!snapshotAdd.hasData ||
                      snapshotAdd.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                      left: widthis(context, 0.02),
                      right: widthis(context, 0.02),
                      top: heightof(context, 0.02),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.1,
                        // color: Colors.black,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(snapshotAdd.data!['name'].toString()),
                          Text(snapshotAdd.data!['state'].toString()),
                          Text(snapshotAdd.data!['city'].toString()),
                          Text(snapshotAdd.data!['pincode'].toString()),
                          Text(snapshotAdd.data!['areaNear'].toString()),
                          Text(snapshotAdd.data!['mobileNumber'].toString()),
                          Text(snapshotAdd.data!['street'].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Text(
                "select a payment ",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: const Text("Online Pay"),
                leading: Radio(
                  value: "online",
                  groupValue: selectedPayment,
                  onChanged: (val) {
                    setState(() {
                      selectedPayment = val.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Cash On delivery"),
                leading: Radio(
                  value: "cod",
                  groupValue: selectedPayment,
                  onChanged: (val) {
                    setState(() {
                      selectedPayment = val.toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CupertinoButton(
        // color: const Color.fromARGB(255, 4, 24, 42),
        child: const Text("Pay Now"),
        onPressed: () async {
          var options = {
            'key': 'rzp_test_HPR933L2nTKRBP',
            'amount': rs * 100,
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
          if (selectedPayment == "cod") {
            FirebaseFirestore.instance.collection("orders").add({
              "address": widget.addId.toString(),
              "product_id": UserSelectedBuyItem.toString(),
              "date": DateTime.now(),
              "buyer": userIn!.email.toString(),
              "paid": false,
              "state": [
                "confirmed  ✅",
              ],
              "cancel": false,
              "vendor": vendorId,
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentSeccess(),
              ),
            );
          } else {
            _razorpay.open(options);
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
