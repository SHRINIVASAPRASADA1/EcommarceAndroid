import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/component/editAddress.dart';
import 'package:myapp/component/history.dart';
import 'package:myapp/signupPage.dart';
import 'package:myapp/variables.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingss extends StatefulWidget {
  const Settingss({Key? key}) : super(key: key);

  @override
  State<Settingss> createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.white,
          ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: heightof(context, 0.15),
            decoration: BoxDecoration(
              // color: const Color.fromARGB(68, 76, 175, 79),
              border: Border.all(
                width: 0.1,
                // color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Image.network(userIn!.photoURL.toString()),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              userIn!.displayName.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              userIn!.email.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.shopping_basket,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "Recent Buys",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.reviews,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "My Reviews",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const GenarateCopan(),
          //       ),
          //     );
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(top: heightof(context, 0.02)),
          //     height: heightof(context, 0.06),
          //     decoration: const BoxDecoration(
          //       color: Color.fromARGB(24, 157, 160, 255),
          //     ),
          //     child: Row(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(
          //             right: widthis(context, 0.02),
          //             left: widthis(context, 0.04),
          //           ),
          //           child: Icon(
          //             Icons.money,
          //             size: widthis(context, 0.08),
          //           ),
          //         ),
          //         const Text(
          //           "redeem code",
          //           style: TextStyle(
          //               fontSize: 22, color: Color.fromARGB(255, 36, 12, 170)),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              // AddAddress(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditAddress(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.place,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "Edit My address",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryOfUser(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.history,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "History",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse("https://api.whatsapp.com/send/?phone=919380869058"),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                top: heightof(context, 0.02),
                left: widthis(context, 0.04),
              ),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: widthis(context, 0.02)),
                    child: Icon(
                      Icons.support,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "contact support",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.email_sharp,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "email support",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleAuthontication()),
                  (route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(top: heightof(context, 0.02)),
              height: heightof(context, 0.06),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(24, 157, 160, 255),
                  ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: widthis(context, 0.02),
                      left: widthis(context, 0.04),
                    ),
                    child: Icon(
                      Icons.logout,
                      size: widthis(context, 0.08),
                    ),
                  ),
                  const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
