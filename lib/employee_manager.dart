import 'dart:io';
import 'dart:async';
import 'package:dairymanagement/reusable/add_new_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reusable/const.dart';
import 'reusable/cards.dart';
import 'reusable/request_server.dart';
import 'dart:convert';
import 'reusable/request_items.dart';

class EmployeeManagerScreen extends StatefulWidget {
  @override
  _EmployeeManagerScreenState createState() => _EmployeeManagerScreenState();
}

class _EmployeeManagerScreenState extends State<EmployeeManagerScreen> {

  var output;

  Future<List<Widget>> getCards() async{
    RequestServer server=RequestServer(action:"select * from instructor",Qtype:"R");
    output=await server.getDecodedResponse();
    List<Widget> _cards=[];
    for(int i=0;i<output.length;i++){
      _cards.add(EmployeeCard(output[i]["ID"],output[i]["name"]));

    }
    //TODO the item names are subject to change depending on the db schema
    return _cards;
  }

  @override
  void initState() {
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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add
          ),
          elevation: 3,
          onPressed: (){
          /*  Navigator.push(context,MaterialPageRoute(builder: (context){
              return AddDetails(pageTypeList.employeeManager);
            }));*/

          showModalBottomSheet(context: context, builder:(context){
            return AddDetails(pageTypeList.employeeManager);
          });
          },
          //TODO This is where employee data insertion happens
        ),
        body: FutureBuilder(
          future: getCards(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(
                  child:CircularProgressIndicator(),
              );
            }
            else{
              return ListView(
                children: snapshot.data,
              );
            }

          },
        )
      ),
    );
  }
}

