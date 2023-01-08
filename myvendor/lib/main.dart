import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myvendor/firebase_options.dart';
import 'package:myvendor/homePage/HomePage.dart';
import 'package:myvendor/signup.dart';
import 'package:myvendor/variable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyAMN-RUFtA3hMLSIunoNoYx8hhxHlEFbhw",
  //       appId: "1:990355535533:web:6f5a63614be403854df824",
  //       messagingSenderId: "990355535533",
  //       projectId: "projectecomarce",
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      // ignore: unnecessary_null_comparison
      home: userIn != null ? const HomePage() : const GoogleAuthontication(),
      // home: HomePage(),
    );
  }
}
