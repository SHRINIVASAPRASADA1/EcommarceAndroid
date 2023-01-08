import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myadmin/home/ProductEdit.dart';
import 'package:myadmin/vari.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
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
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        color: Colors.white,
                        width: addwidth(context, 0.90),
                        height: 120,
                        child: MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("products")
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "delete ?",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductEdit(
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
                  // padding: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: Image.network(
                      snapshot.data!.docs[index]['img'][0],
                      fit: BoxFit.cover,
                    ),
                    title: Text(snapshot.data!.docs[index]['title']),
                    subtitle:
                        Text("⭐" * snapshot.data!.docs[index]['rattings']),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: const Icon(
              Icons.plus_one,
            ),
          ),
        );
      },
    );
  }
}
