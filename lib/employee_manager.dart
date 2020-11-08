import 'dart:io';
import 'dart:async';
import 'package:dairymanagement/reusable/add_new_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable/const.dart';
import 'reusable/cards.dart';
import 'reusable/request_server.dart';
import 'dart:convert';
import 'reusable/request_items.dart';

class EmployeeManagerScreen extends StatefulWidget {
  String username;
  EmployeeManagerScreen(this.username);
  @override
  _EmployeeManagerScreenState createState() => _EmployeeManagerScreenState(this.username);
}

class _EmployeeManagerScreenState extends State<EmployeeManagerScreen> {
  String username="";
  var output;
  bool populated=false;
  _EmployeeManagerScreenState(this.username);

  Future<void> getFromServer() async{
    RequestServer server=RequestServer(action:"select EmpID,Name,PhoneNumber from Employees",Qtype:"R");
    output=await server.getDecodedResponse();
    setState(() {
      populated=true;
    });
  }

  List<Widget> getCards() {
    List<Widget> _cards=[];
    for(int i=0;i<output.length;i++){
      _cards.add(EmployeeCard(username,output[i]["EmpID"],output[i]["Name"],output[i]["PhoneNumber"]));
    }
    return _cards;
  }

  @override
  void initState() {
    getFromServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(populated==false){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Employees"
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(FontAwesomeIcons.powerOff,color: Colors.white,),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add
          ),
          elevation: 3,
          onPressed: () async{
          /*  Navigator.push(context,MaterialPageRoute(builder: (context){
              return AddDetails(pageTypeList.employeeManager);
            })); */

          await showModalBottomSheet(context: context, builder:(context){
            return AddDetails(pageTypeList.employeeManager);
          });
          setState(() {
            populated=false;
          });
          await getFromServer();
          },
        ),
        body:ListView(
                children: getCards(),
              ),
      ),
    );
  }
}

