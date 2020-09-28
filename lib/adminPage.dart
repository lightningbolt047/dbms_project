import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'reusable/const.dart';
import 'reusable/request_server.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //
  @override
  void initState(){
    RequestServer server=RequestServer(action:"select * from instructor",Qtype:"R");
    var output=server.getDecodedResponse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        backgroundColor: Colors.blue,
      ),

    );
  }
}
