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

  String _outletName,_outletPhoneNumber,_area,_outletID;
  double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;

  _AddDetailsState(this.pageType);

  dynamic getBodyContent(){
    if(pageType==pageTypeList.employeeManager){
      return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
          child: ListView(
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
                          keyboardType: TextInputType.datetime,
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
    if(pageType==pageTypeList.outletManager){
      return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Outlet Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Enter Outlet Name",
                          ),
                          onChanged: (string){
                            _outletName=string;
                          },
                        ),
                      ),
                    ),
                    Text("Phone Number: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Outlet Phone Number",
                          ),
                          onChanged: (string){
                            _outletPhoneNumber=string;
                          },
                        ),
                      ),
                    ),
                    Text("Outlet ID: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,2,0),
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Outlet ID",
                          ),
                          onChanged: (string){
                            _outletID=string;
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
                    Expanded(
                      child: Row(
                        children: [
                          Text("Send Milk: $_reqMilk "),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqMilk<=5000){
                                  _reqMilk+=10;
                                }
                              });
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqMilk>0){
                                  _reqMilk-=10;
                                }
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text("Send Butter: $_reqButter "),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqButter<=5000){
                                  _reqButter+=10;
                                }
                              });
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqButter>0){
                                  _reqButter-=10;
                                }
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text("Send Cheese: $_reqCheese "),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqCheese<=5000){
                                  _reqCheese+=10;
                                }
                              });
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqCheese>0){
                                  _reqCheese-=10;
                                }
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text("Send Yogurt: $_reqYogurt "),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqYogurt<=5000){
                                  _reqYogurt+=10;
                                }
                              });
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                              setState(() {
                                if(_reqYogurt>0){
                                  _reqYogurt-=10;
                                }
                              });
                            }),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Area: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Outlet Location",
                          ),
                          onChanged: (string){
                            _area=string;
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
    if(pageType==pageTypeList.outletManager){
      return "Add new Outlet";
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
