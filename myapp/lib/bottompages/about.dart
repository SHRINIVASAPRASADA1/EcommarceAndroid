import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/variables.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("News")
          .where("date", isEqualTo: DateTime.now().day)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                FirebaseFirestore.instance
                    .collection("News")
                    .doc(snapshot.data!.docs[index].id)
                    .delete();
              },
              child: Container(
                // height: heightof(context, 0.50),
                // width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.2,
                    color: Colors.white,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: heightof(context, 0.40),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            snapshot.data!.docs[index]['imglink'].toString(),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CircularProgressIndicator(),
                      ),
                    ),
                    Text(DateTime.now().toString()),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(snapshot.data!.docs[index]['des']),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
