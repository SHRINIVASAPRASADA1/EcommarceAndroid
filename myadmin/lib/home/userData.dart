// ignore: file_names
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:myadmin/home/UserCart.dart';
import 'package:myadmin/home/userHistory.dart';
import 'package:myadmin/home/usersAddress.dart';
import 'package:myadmin/vari.dart';

class UserPersonalData extends StatefulWidget {
  String id = "";
  UserPersonalData({Key? key, required this.id}) : super(key: key);

  @override
  State<UserPersonalData> createState() => _UserPersonalDataState();
}

class _UserPersonalDataState extends State<UserPersonalData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: Colors.white,
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: MaterialButton(
              minWidth: double.infinity,
              height: addHeight(context, 0.10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHistory(),
                  ),
                );
              },
              child: const Text("history"),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: Colors.white,
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: MaterialButton(
              minWidth: double.infinity,
              height: addHeight(context, 0.10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserAddress(),
                  ),
                );
              },
              child: const Text("address"),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: Colors.white,
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: MaterialButton(
              minWidth: double.infinity,
              height: addHeight(context, 0.10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserCart(),
                  ),
                );
              },
              child: const Text("cart"),
            ),
          ),
        ],
      ),
    );
  }
}
