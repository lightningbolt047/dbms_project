import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reusable/const.dart';
import 'reusable/cards.dart';
import 'reusable/request_server.dart';
import 'dart:convert';

class EmployeeManagerScreen extends StatefulWidget {
  @override
  _EmployeeManagerScreenState createState() => _EmployeeManagerScreenState();
}

class _EmployeeManagerScreenState extends State<EmployeeManagerScreen> {

  var output;

  dynamic getItems() async{
    RequestServer server=RequestServer(action:"select * from instructor",Qtype:"R");
    output=await server.getDecodedResponse();
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Employees"
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.perm_identity,
                        size: 20,
                      ),
                      sizedBoxSmallInRow,
                      Text("FirstName"),
                      SizedBox(
                        width: 5,
                      ),
                      Text("LastName"),
                      sizedBoxLargeInRow,
                      phoneIcon,
                      sizedBoxSmallInRow,
                      Text("90910913"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
