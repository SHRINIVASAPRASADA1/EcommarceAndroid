// ignore_for_file: unrelated_type_equality_checks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/bottompages/Myorder.dart';
import 'package:myapp/bottompages/about.dart';
import 'package:myapp/bottompages/home.dart';
import 'package:myapp/bottompages/settings.dart';
import 'package:myapp/component/cartItems.dart';
import 'package:myapp/component/editAddress.dart';
import 'package:myapp/component/history.dart';
import 'package:myapp/component/search.dart';
import 'package:myapp/signupPage.dart';
import 'package:myapp/variables.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection("AllUser")
            .doc(userIn!.email.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData) {
            return MaterialApp(
              theme: ThemeData(
                brightness: Brightness.dark,
              ),
              // color: const Color.fromARGB(255, 255, 255, 255),
              home: userIn != null
                  ? const HomePage()
                  : const GoogleAuthontication(),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
              primaryColor: Colors.green,
              brightness: snapshot.data!['theme'] == true
                  ? Brightness.dark
                  : Brightness.light,
            ),
            // color: const Color.fromARGB(255, 255, 255, 255),
            home: userIn != null
                ? const HomePage()
                : const GoogleAuthontication(),
          );
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    const HomePage1(),
    const MyOrderPage(),
    const AboutPage(),
    const Settingss(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text(
          "NatureThings",
          style: TextStyle(shadows: [
            Shadow(
              // color: Color.fromARGB(255, 0, 0, 0),
              blurRadius: 2.0,
              offset: Offset(1.0, 1.0),
            )
          ]),
        ),
        iconTheme: const IconThemeData(
            // color: Color.fromARGB(255, 0, 0, 0),
            ),
        // shadowColor: const Color.fromARGB(255, 253, 253, 253),
        // backgroundColor: appbar,
        actions: [
          IconButton(
            // color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchProduct(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            // color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartItems(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              // color: Color.fromARGB(250, 207, 201, 255),
              ),
          child: pages[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        currentIndex: currentIndex,
        // selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        // unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        selectedLabelStyle: const TextStyle(
            // color: Color.fromARGB(255, 255, 252, 252),
            ),
        // selectedIconTheme: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              // color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          BottomNavigationBarItem(
            label: "track",
            icon: Icon(
              Icons.track_changes,
              // color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          BottomNavigationBarItem(
            label: "news",
            icon: Icon(
              Icons.newspaper,
              // color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          BottomNavigationBarItem(
            label: "settings",
            icon: Icon(
              Icons.settings,
              // color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: heightof(context, 0.26),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1,
                    // color: Colors.black,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: widthis(context, 0.12),
                      backgroundImage: NetworkImage(
                        userIn!.photoURL.toString(),
                      ),
                    ),
                    Text(userIn!.email.toString()),
                    Text(userIn!.displayName.toString()),
                    Text(
                        "Joined : ${userIn!.metadata.creationTime.toString()}"),
                    Text(
                        "Last Login : ${userIn!.metadata.lastSignInTime.toString()}"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditAddress(),
                    ),
                  );
                },
                child: const ListTile(
                  title: Text("Edit My address"),
                  leading: Icon(
                    Icons.place,
                    // color: Colors.black,
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
                child: const ListTile(
                  title: Text("History"),
                  leading: Icon(
                    Icons.history,
                    // color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        "https://api.whatsapp.com/send/?phone=919380869058"),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const ListTile(
                  title: Text("contact support"),
                  leading: Icon(
                    Icons.support,
                    // color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Uri urls = Uri.parse("http://44.202.70.45/");
                  if (await launchUrl(
                    urls,
                    mode: LaunchMode.externalApplication,
                  )) ;
                },
                child: const ListTile(
                  title: Text("Goto WebSite"),
                  leading: Icon(
                    Icons.email_sharp,
                    // color: Colors.black,
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
                child: const ListTile(
                  title: Text("Logout"),
                  leading: Icon(
                    Icons.logout,
                    // color: Colors.black,
                  ),
                ),
              ),
              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection("AllUser")
                      .doc(userIn!.email)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularStepProgressIndicator(totalSteps: 4),
                      );
                    }
                    return SwitchListTile(
                      title: const Text("Dark Theme ?"),
                      value: snapshot.data!['theme'],
                      onChanged: (val) {
                        FirebaseFirestore.instance
                            .collection("AllUser")
                            .doc(userIn!.email)
                            .set({
                          "theme": val,
                        });
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
