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

  _AddDetailsState(this.pageType);

  dynamic getBodyContent(){
    if(pageType==pageTypeList.employeeManager){
      String _empID,_empName,_phoneNumber,_job,_dateOfJoin,_address;
      double _salary,_amountPayable=0;
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
                    Text("Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Employee's Name",
                          ),
                          onChanged: (string){
                            _empName=string;
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
                            labelText: "YYYY-MM-DD",
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
                            _salary=double.tryParse(string);
                          },
                        ),
                      ),
                    ),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: (){
                      if(_empID==null || _empName==null || _phoneNumber==null || _job==null || _dateOfJoin==null || _address==null || _salary==null){
                        print("One or more details missing/invalid. Exiting gracefully!");
                      }
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
      String _outletName,_outletPhoneNumber,_area,_outletID;
      double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;
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
                      //TODO perform sql actions here
                      if(_area==null || _outletID==null || _outletPhoneNumber==null){
                        print("One or more details are missing/invalid. Gracefully exiting");
                      }
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
    if(pageType==pageTypeList.admin){
      String _inputUsername,_inputID,_inputNewPassword,_inputRepeatPassword;
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Username: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,30,0),
                              //width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "New Username",
                                ),
                                onChanged: (string){
                                  _inputUsername=string;
                                },
                              ),
                            ),
                          ),
                          Text("New Password: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,30,0),
                              //width: 200,
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Enter new Password",
                                ),
                                onChanged: (string){
                                  _inputNewPassword=string;
                                },
                              ),
                            ),
                          ),
                          Text("Repeat Password: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,2,0),
                              width: 200,
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Repeat Password",
                                ),
                                onChanged: (string){
                                  _inputRepeatPassword=string;
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
                                Text("ID (Employee or OutletID): "),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(1,0,30,0),
                                    //width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "Leave blank if Not Applicable",
                                      ),
                                      onChanged: (string){
                                        _inputID=string;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: (){
                                    //TODO perform sql actions here and close the screen
                                    if(_inputUsername==null || _inputNewPassword==null || _inputRepeatPassword==null){
                                      print("Invalid/Missing details! Exiting gracefully");
                                    }
                                    Navigator.pop(context);
                                  },
                                  ),

                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    if(pageType==pageTypeList.procurementManager){
      String _producerName,_producerID,_producerPhoneNumber,_producerArea;
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
                    Text("Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "MilkProducer's Name",
                          ),
                          onChanged: (string){
                            _producerName=string;
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
                            labelText: "MilkProducer's Phone Number",
                          ),
                          onChanged: (string){
                            _producerPhoneNumber=string;
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
                            labelText: "Producer's new ID",
                          ),
                          onChanged: (string){
                            _producerID=string;
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
                    Text("Area: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Producer's Area (lower case)",
                          ),
                          onChanged: (string){
                            _producerArea=string;
                          },
                        ),
                      ),
                    ),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: (){
                      if(_producerID==null || _producerArea==null || _producerPhoneNumber==null || _producerName==null){
                        print("One or more details missing/invalid. Exiting gracefully!");
                      }
                      //TODO Amount and AmountPayable is 0 by default. So no need to declare new variable for it and waste memoru
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
    if(pageType==pageTypeList.transport){
      String _truckID,_truckArea,_truckNumberPlate,_truckEmpID;
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("TruckID: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,30,0),
                              //width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Enter TruckID",
                                ),
                                onChanged: (string){
                                  _truckID=string;
                                },
                              ),
                            ),
                          ),
                          Text("EmployeeID: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,30,0),
                              //width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Employee ID",
                                ),
                                onChanged: (string){
                                  _truckEmpID=string;
                                },
                              ),
                            ),
                          ),
                          Text("NumberPlate: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,2,0),
                              width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Vehicle Number Plate",
                                ),
                                onChanged: (string){
                                  _truckNumberPlate=string;
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
                                Text("Area: "),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(1,0,30,0),
                                    //width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "Area (lower case)",
                                      ),
                                      onChanged: (string){
                                        _truckArea=string;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: (){
                                    //TODO perform sql actions here and close the screen
                                    if(_truckID==null || _truckArea==null || _truckNumberPlate==null || _truckEmpID==null){
                                      print("Invalid/Missing details! Exiting gracefully");
                                    }
                                    Navigator.pop(context);
                                  },
                                  ),

                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    if(pageType==pageTypeList.procurementManager){
      return "Add new Milk Producer";
    }
    if(pageType==pageTypeList.admin){
      return "Create new User Account";
    }
    if(pageType==pageTypeList.transport){
      return "Assign Driver to Truck";
    }
    return "Non Null AppBar name to keep from crashing😂";
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

class PasswordConfirm extends StatefulWidget {
  @override
  _PasswordConfirmState createState() => _PasswordConfirmState();
}

class _PasswordConfirmState extends State<PasswordConfirm> {
  String _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              "Confirm Your password"
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Enter your password to make sure its you: "),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(1,0,30,0),
                          //width: 200,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Your password",
                            ),
                            onChanged: (string){
                              _password=string;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child:RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,), action: (){
                          Navigator.pop(context, _password);
                        },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ), //This container is temp, widget get from function
      ),
    );
  }
}

