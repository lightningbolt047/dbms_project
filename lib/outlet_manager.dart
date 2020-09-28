import 'package:flutter/material.dart';
import 'reusable/const.dart';
import 'reusable/cards.dart';

class OutletManagerScreen extends StatefulWidget {
  @override
  _OutletManagerScreenState createState() => _OutletManagerScreenState();
}

class _OutletManagerScreenState extends State<OutletManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Outlet Details"
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
        children: [
          outletCard("Very cool name", 10000, "2823782", 6, 0, 0, 0, 4000,"42069"),
          outletCard("Not so cool name", 5000, "582378237", 6, 0, 0, 0, 3000,"96"),
          outletCard("Worst name ever", 5000, "2823", 6, 0, 0, 0, 4000,"0192"),
        ],
          ),
      ),
    );
  }
}
