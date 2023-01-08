import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myvendor/homePage/Delivery.dart';
import 'package:myvendor/homePage/Products.dart';
import 'package:myvendor/homePage/addnews.dart';
import 'package:myvendor/homePage/profile.dart';
import 'package:myvendor/homePage/uploadProduct.dart';
import 'package:myvendor/variable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Shop"),
      ),
      body: Wrap(
        children: [
          addItem(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeliveryUpdate(),
              ),
            );
          }, Icons.fire_truck, "Orders"),
          addItem(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadNewProduct(),
              ),
            );
          }, Icons.upload_file_outlined, "Upload Product"),
          addItem(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllProducts(),
              ),
            );
          }, Icons.edit_note, "Edit Product"),
          addItem(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Profile(),
              ),
            );
          }, Icons.people, "Profile"),
          addItem(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNews(),
              ),
            );
          }, Icons.new_label_outlined, "Add news"),
        ],
      ),
    );
  }

  addItem(myfun, myicon, mytext) {
    return GestureDetector(
      onTap: myfun,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(73, 255, 255, 255),
        ),
        width: widthis(context, 0.42),
        child: Column(
          children: [
            Icon(
              myicon,
              size: 80,
            ),
            Text(
              mytext,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
