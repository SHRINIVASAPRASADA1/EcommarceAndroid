import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/home/handleVendors.dart';

class VendorsOnEcom extends StatefulWidget {
  const VendorsOnEcom({Key? key}) : super(key: key);

  @override
  State<VendorsOnEcom> createState() => _VendorsOnEcomState();
}

class _VendorsOnEcomState extends State<VendorsOnEcom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("sellers").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DateTime now = DateTime.parse(
                  snapshot.data!.docs[index]['dateofjoin'].toDate().toString());
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HandleVendor(id: snapshot.data!.docs[index].id),
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
                    title: Text(snapshot.data!.docs[index]['name']),
                    subtitle: Text(now.toString()),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(snapshot.data!.docs[index]['img']),
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
