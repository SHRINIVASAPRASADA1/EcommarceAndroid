import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/home/userData.dart';
import 'package:myadmin/vari.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("AllUser").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentHistory = snapshot.data!.docs[index].id.toString();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserPersonalData(id: snapshot.data!.docs[index].id),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(195, 0, 0, 0),
                        blurRadius: 3,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                    border: Border.all(
                      width: 0.4,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    subtitle: const Text("User Of App"),
                    leading: const Icon(
                      Icons.people,
                    ),
                    title: Text(
                      snapshot.data!.docs[index].id.toString(),
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
