import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myadmin/vari.dart';

class HandleVendor extends StatefulWidget {
  String id = "";
  HandleVendor({Key? key, required this.id}) : super(key: key);

  @override
  State<HandleVendor> createState() => _HandleVendorState();
}

class _HandleVendorState extends State<HandleVendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.id)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          DateTime now =
              DateTime.parse(snapshot.data!['dateofjoin'].toDate().toString());
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: addHeight(context, 0.25),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: Image.network(snapshot.data!['img']),
              ),
              Text(
                snapshot.data!['name'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Joined : ${now.toString()}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Location : ${snapshot.data!['from']}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Available Stock : ${snapshot.data!['products'].toString()}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: const Text(
                    "Upload News Post",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CupertinoSwitch(
                    value: snapshot.data!['canuploadnews'],
                    onChanged: (val) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(widget.id)
                            .update({
                          "canuploadnews": val,
                        });
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: const Text(
                    "Upload New Products",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CupertinoSwitch(
                    value: snapshot.data!['canuploadproduct'],
                    onChanged: (val) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(widget.id)
                            .update({
                          "canuploadproduct": val,
                        });
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: const Text(
                    "Block User from App",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CupertinoSwitch(
                    value: snapshot.data!['blocked'],
                    onChanged: (val) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(widget.id)
                            .update({
                          "blocked": val,
                        });
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
