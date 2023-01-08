// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  String imglink = "";
  FullImageView({Key? key, required this.imglink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Image.network(imglink.toString()),
      ),
    );
  }
}
