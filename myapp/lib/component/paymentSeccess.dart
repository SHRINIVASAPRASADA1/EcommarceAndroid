import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:myapp/main.dart';
import 'package:myapp/variables.dart';

class PaymentSeccess extends StatefulWidget {
  const PaymentSeccess({Key? key}) : super(key: key);

  @override
  State<PaymentSeccess> createState() => _PaymentSeccessState();
}

class _PaymentSeccessState extends State<PaymentSeccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              // color: const Color.fromARGB(253, 86, 0, 161),
              border: Border.all(
            width: 0.02,
            // color: Colors.black,
          )),
          child: const Text(
            "Continue Shopping......",
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: heightof(context, 0.10),
                ),
                child: const Text(
                  "Thank You For Shopping...",
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const Text(
                "Your Order as Been placed......",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Container(
                child: Lottie.asset("assets/loti/payment.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
