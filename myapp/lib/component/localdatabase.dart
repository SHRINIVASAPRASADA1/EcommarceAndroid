// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myapp/variables.dart';

addDarkMode() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("AllUser")
        .doc(userIn!.email)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> product) {
      return SwitchListTile(
        title: const Text("Dark Mode"),
        value: product.data!['darkmode'],
        onChanged: (val) {
          if (product.data!['darkmode'] == false) {
            setBrightness = Brightness.dark;
          }
          if (product.data!['darkmode'] == true) {
            setBrightness = Brightness.light;
          }

          FirebaseFirestore.instance
              .collection("AllUser")
              .doc(userIn!.email)
              .update({
            "darkmode": val,
          });
        },
      );
    },
  );
}
