import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'reusable/const.dart';
import 'reusable/request_server.dart';
import 'reusable/add_new_details.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddDetails(pageTypeList.admin),

    );
  }
}
