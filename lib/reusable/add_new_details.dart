import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AddDetails extends StatefulWidget {

  final pageType;
  AddDetails(this.pageType);
  @override
  _AddDetailsState createState() => _AddDetailsState(this.pageType);
}

class _AddDetailsState extends State<AddDetails> {
  final pageType;
  String _empID,_firstName,_lastName,_phoneNumber,_job,_dateOfJoin,_address;
  double _salary,_amountPayable=0;

  _AddDetailsState(this.pageType);

  dynamic getBodyContent(){
    if(pageType==pageTypeList.employeeManager){
      return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("First Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's First Name",
                          ),
                          onChanged: (string){
                            _firstName=string;
                          },
                        ),
                      ),
                    ),
                    Text("Last Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's First Name",
                          ),
                          onChanged: (string){
                            _lastName=string;
                          },
                        ),
                      ),
                    ),
                    Text("Phone Number: "),
                    Expanded(
                      child: Container(
                      padding: EdgeInsets.fromLTRB(1,0,2,0),
                      width: 200,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Employee's Phone Number",
                        ),
                        onChanged: (string){
                          _phoneNumber=string;
                        },
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("ID: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's ID",
                          ),
                          onChanged: (string){
                            _empID=string;
                          },
                        ),
                      ),
                    ),
                    Text("Job: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's Job",
                          ),
                          onChanged: (string){
                            _job=string;
                          },
                        ),
                      ),
                    ),
                    Text("Date of Join: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,2,0),
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Date of Join",
                          ),
                          onChanged: (string){
                            _dateOfJoin=string;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Address: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's address",
                          ),
                          onChanged: (string){
                            _address=string;
                          },
                        ),
                      ),
                    ),
                    Text("Salary: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Initial Salary",
                          ),
                          onChanged: (string){
                            _salary=double.parse(string);
                          },
                        ),
                      ),
                    ),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: (){
                      Navigator.pop(context);
                    },),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  String getAppBarText(){
    if(pageType==pageTypeList.employeeManager){
      return "Add new Employee";
    }
    return "Non Null AppBar name";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            getAppBarText()
          ),
        ),
        body: getBodyContent(), //This container is temp, widget get from function
      ),
    );
  }
}
