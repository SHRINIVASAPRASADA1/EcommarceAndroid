import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/main.dart';
import 'package:myapp/variables.dart';

class GoogleAuthontication extends StatefulWidget {
  const GoogleAuthontication({Key? key}) : super(key: key);

  @override
  State<GoogleAuthontication> createState() => _GoogleAuthonticationState();
}

class _GoogleAuthonticationState extends State<GoogleAuthontication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shadowColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "continue with google",
          style: TextStyle(
              // color: Colors.black,
              ),
        ),
      ),
      body: Center(
        child: GestureDetector(
            onTap: () async {
              await signInWithGoogle();
              userIn = FirebaseAuth.instance.currentUser;

              if (userIn != null) {
                FirebaseFirestore.instance
                    .collection("AllUser")
                    .doc(userIn!.email)
                    .set({
                  "theme": false,
                });
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false);
              }
            },
            child: Container(
              margin: EdgeInsets.all(widthis(context, 0.15)),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: const Color.fromARGB(74, 33, 149, 243),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: widthis(context, 0.02)),
                    width: MediaQuery.of(context).size.width * 0.11,
                    // height: MediaQuery.of(context).size.height * 0.11,
                    child: Image.asset(
                      "assets/img/googleLogo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: widthis(context, 0.02)),
                    child: const Text(
                      "SignIn With Google",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
