import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myadmin/home/ProductEdit.dart';
import 'package:myadmin/home/editReqProduct.dart';

class VendorProductReq extends StatefulWidget {
  const VendorProductReq({Key? key}) : super(key: key);

  @override
  State<VendorProductReq> createState() => _VendorProductReqState();
}

class _VendorProductReqState extends State<VendorProductReq> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("newUploadRequest").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  FirebaseFirestore.instance
                      .collection("newUploadRequest")
                      .doc(snapshot.data!.docs[index].id)
                      .get()
                      .then((value) => {
                            FirebaseFirestore.instance
                                .collection("products")
                                .add({
                              "about": value['about'],
                              "deal": int.parse(value['deal'].toString()),
                              "img": value['img'],
                              "info": value['info'],
                              "keyword": value['keyword'],
                              "offer": value['offer'],
                              "price": int.parse(value['price'].toString()),
                              "stock": int.parse(value['stock'].toString()),
                              "title": value['title'],
                              "vendor": value['vendor'],
                              "rattings": int.parse(2.toString()),
                            }),
                            FirebaseFirestore.instance
                                .collection("historyOfAdmin")
                                .add({
                              "about": value['about'],
                              "deal": int.parse(value['deal'].toString()),
                              "img": value['img'],
                              "info": value['info'],
                              "keyword": value['keyword'],
                              "offer": value['offer'],
                              "price": int.parse(value['price'].toString()),
                              "stock": int.parse(value['stock'].toString()),
                              "title": value['title'],
                              "vendor": value['vendor'],
                              "rattings": int.parse(2.toString()),
                            })
                          });
                },
                onLongPress: () {
                  FirebaseFirestore.instance
                      .collection("newUploadRequest")
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditVendorProduct(
                        product_id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.1,
                      color: Colors.white,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    leading:
                        Image.network(snapshot.data!.docs[index]['img'][0]),
                    title: Text(snapshot.data!.docs[index]['title']),
                    subtitle:
                        Text("⭐" * snapshot.data!.docs[index]['rattings']),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
