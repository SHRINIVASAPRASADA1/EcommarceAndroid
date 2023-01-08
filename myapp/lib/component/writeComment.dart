import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myapp/variables.dart';

// ignore: must_be_immutable
class WriteComment extends StatefulWidget {
  String productId = "";
  WriteComment({Key? key, required this.productId}) : super(key: key);

  @override
  State<WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<WriteComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        // backgroundColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("products")
                  .doc(widget.productId.toString())
                  .collection("comment")
                  .add({
                "comment": comment.text,
                "userName": userIn!.displayName,
                "date": DateTime.now(),
              });
              comment.text = "";
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
        child: TextFormField(
          controller: comment,
          autofocus: true,
          // cursorColor: Colors.black,
          maxLines: 80,
          decoration: InputDecoration(
            filled: true,
            // fillColor: const Color.fromARGB(58, 88, 87, 87),
            hintText: "Write A comment ...",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                // color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                // color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
