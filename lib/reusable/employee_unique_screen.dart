import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'request_server.dart';
import 'const.dart';
import 'add_new_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class EmployeeUniqueScreen extends StatefulWidget {
  final String username,id;
  final pageType;
  EmployeeUniqueScreen(this.username,this.id,this.pageType);
  @override
  _EmployeeUniqueScreenState createState() => _EmployeeUniqueScreenState(this.username,this.id,this.pageType);
}

class _EmployeeUniqueScreenState extends State<EmployeeUniqueScreen> {
  String name="",phoneNumber="",dateOfJoin="",id="",job="",address="";
  String username="";
  double salary=0,amountPayable=0;
  var pageType;
  String _inputPassword;

  bool authorized=true;
  _EmployeeUniqueScreenState(this.username,this.id,this.pageType);

  Future<bool> populateData() async{
    RequestServer server = RequestServer(action: "select * from Employees where EmpID=$id", Qtype: "R");
    var items= await server.getDecodedResponse();
    setState(() {
      name=items[0]["Name"];
      phoneNumber=items[0]["PhoneNumber"];
      job=items[0]["Job"];
      address=items[0]["Address"];
      amountPayable=double.parse(items[0]["AmountPayable"]);
      salary=double.parse(items[0]["Salary"]);
      dateOfJoin=items[0]["DateOfJoin"];
    });
    return true;
  }

  Function getCreditSalaryFunction(){
    return () async{
      final _returnedData= await showModalBottomSheet(context: context, builder:(context){
        return PasswordConfirm();  //Temp testing
      });
      if(_returnedData==null){
        setState(() {
          authorized=false;
        });
        Timer(const Duration(seconds: 10),(){
          setState(() {
            authorized=true;
          });
        });
        return;
      }
      RequestServer server=RequestServer();
      bool authState=await server.checkCredentials(username, _returnedData);
      if(authState){
        RequestServer server=RequestServer(action: "select Amount from Expenses where onDate=\"${dates[date]}\"",Qtype: "R");
        var items=await server.getDecodedResponse();
        double curExpense=0;
        curExpense=double.parse(items[0]['Amount']);
        curExpense+=amountPayable;
        server.setAction("UPDATE Expenses SET Amount=$curExpense where onDate=\"${dates[date]}\"");
        server.setQtype("W");
        var response=await server.getDecodedResponse();
        server.setAction("UPDATE Employees SET AmountPayable=0 where EmpID=\"$id\"");
        var response1=await server.getDecodedResponse();
        server.setAction("UPDATE NetAmount SET Expense=$curExpense,Profit=Income-Expense where onDate=\"${dates[date]}\"");
        var response2=await server.getDecodedResponse();
        if(response.toString().compareTo("OK")==0 && response1.toString().compareTo("OK")==0 && response2.toString().compareTo("OK")==0){
          setState(() {
            amountPayable=0;
            authorized=true;
          });
          return;
        }
        print("An error occurred");
        print(response.toString());
        print(response1.toString());
        print(response2.toString());
      }
      else{
        setState(() {
          authorized=false;
        });
        Timer(const Duration(seconds: 10),(){
          setState(() {
            authorized=true;
          });
        });
      }
    };
  }

  Color getCreditSalaryButtonColor(){
    if(authorized==true){
      return Colors.blueAccent;
    }
    else{
      return Colors.red;
    }
  }

  String getCreditSalaryButtonText(){
    if(amountPayable==0){
      return "Salary Credited";
    }
    if(authorized==false){
      return "You are not authorized";
    }
    else{
      return 'Credit Salary: $amountPayable';
    }
  }

  @override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child:SizedBox(
                height: 60,
              ),
            ),
            Expanded(
              child: Text(
                "Employee Details",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  fontFamily: screenHeadFont
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                ),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                              Text(name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: screenContentFont
                                ),
                              )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text(id,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: screenContentFont
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text(phoneNumber,
                                  style: TextStyle(
                                    fontSize: 20,fontFamily: screenContentFont
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_sharp,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text(dateOfJoin,
                                  style: TextStyle(
                                    fontFamily: screenContentFont,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("$salary",
                                  style: TextStyle(
                                    fontFamily: screenContentFont,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text(job,
                                  style: TextStyle(
                                    fontFamily: screenContentFont,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text(address,
                                  style: TextStyle(
                                    fontFamily: screenContentFont,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                  child: FlatButton(
                                    color: getCreditSalaryButtonColor(),
                                    textColor: Colors.white,
                                    child: Text(getCreditSalaryButtonText(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: screenHeadFont,
                                    ),
                                    ),
                                    onPressed: (pageType==pageTypeList.employeeManager && amountPayable>0)?getCreditSalaryFunction():null ,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                  child: FlatButton(
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    child: Text("Cancel",
                                      style: TextStyle(
                                        fontFamily: screenHeadFont,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
