import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dairymanagement/reusable/request_server.dart';


class AddDetails extends StatefulWidget {

  final pageType;
  AddDetails(this.pageType);
  @override
  _AddDetailsState createState() => _AddDetailsState(this.pageType);
}

class _AddDetailsState extends State<AddDetails> {
  String _errorText="default";
  Color _errorTextColor;
  bool _errorTextVisible=false;
  final pageType;

  final List<TextEditingController> _controllers=[];

  double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;

  String _outletName,_outletPhoneNumber,_area,_outletID;

  String _inputUsername,_inputID,_inputNewPassword,_inputRepeatPassword,_inputUserType;

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
      for(int i=0;i<4;i++){
        _controllers.add(TextEditingController());
      }
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
                          controller: _controllers[0],
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
                          controller: _controllers[1],
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
                          controller: _controllers[2],
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                                  _outletName=_controllers[0].text;
                                  _outletPhoneNumber=_controllers[1].text;
                                  _outletID=_controllers[2].text;
                                  _area=_controllers[3].text;
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
                          controller: _controllers[3],
                          decoration: InputDecoration(
                            labelText: "Outlet Location",
                          ),
                          onChanged: (string){
                            _area=string;
                          },
                        ),
                      ),
                    ),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: () async{
                      //TODO perform sql actions here
                      if(_area==null || _outletID==null || _outletPhoneNumber==null){
                        setState(() {
                            _errorText="Invalid/Missing details!";
                            _errorTextColor=Colors.red;
                            _errorTextVisible=true;
                            _outletName=_controllers[0].text;
                            _outletPhoneNumber=_controllers[1].text;
                            _outletID=_controllers[2].text;
                            _area=_controllers[3].text;
                        });
                        return;
                      }
                      RequestServer server = RequestServer(action: "select outID from Outlets where outID=\"$_outletID\"", Qtype: "R");
                      var items= await server.getDecodedResponse();
                      if(items.toString().compareTo("Empty")==0){
                        RequestServer serverInsert=RequestServer(action: "insert into Outlets values(\"$_outletID\",\"$_outletName\",\"$_outletPhoneNumber\",0,0,\"${_area.toLowerCase()}\")",Qtype: "W");
                        var result=await serverInsert.getDecodedResponse();
                        serverInsert.setAction("insert into Required values(\"$_outletID\",0,0,0,0)");
                        serverInsert.setQtype("W");
                        var result1=await serverInsert.getDecodedResponse();
                        serverInsert.setAction("insert into Available values(\"$_outletID\",$_reqMilk,$_reqYogurt,$_reqCheese,$_reqButter)");
                        serverInsert.setQtype("W");
                        var result2=await serverInsert.getDecodedResponse();
                        if(result.toString().compareTo("OK")==0 && result1.toString().compareTo("OK")==0 && result2.toString().compareTo("OK")==0){
                          setState(() {
                            _errorText="New Outlet Added Successfully";
                            _errorTextColor=Colors.green;
                            _errorTextVisible=true;
                            for(int i=0;i<4;i++){
                              _controllers[i].clear();
                            }
                            Navigator.pop(context);
                          });
                        }
                        else{
                          setState(() {
                            _errorText="Something went wrong";
                            _errorTextColor=Colors.red;
                            _errorTextVisible=true;
                            
                            _outletName=_controllers[0].text;
                            _outletPhoneNumber=_controllers[1].text;
                            _outletID=_controllers[2].text;
                            _area=_controllers[3].text;
                          });
                        }
                      }
                      else{
                        setState(() {
                          _errorText="Outlet already exists";
                          _errorTextColor=Colors.red;
                          _errorTextVisible=true;

                          _outletName=_controllers[0].text;
                          _outletPhoneNumber=_controllers[1].text;
                          _outletID=_controllers[2].text;
                          _area=_controllers[3].text;
                        });
                      }

                      //Navigator.pop(context);
                    },),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Visibility(
                  child: Text(_errorText,style: TextStyle(
                      color: _errorTextColor
                  ),),
                  visible: _errorTextVisible,
                ),
              )
            ],
          ),
        ),
      );
    }
    if(pageType==pageTypeList.admin){
      for(int i=0;i<5;i++){
        _controllers.add(TextEditingController());
      }
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
                                controller: _controllers[0],
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
                                controller: _controllers[1],
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
                                controller: _controllers[2],
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
                                Text("User Type: "),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(1,0,30,0),
                                    //width: 200,
                                    child: TextField(
                                      controller: _controllers[3],
                                      decoration: InputDecoration(
                                        labelText: "Account Type",
                                      ),
                                      onChanged: (string){
                                        _inputUserType=string;
                                      },
                                    ),
                                  ),
                                ),
                                Text("ID (Employee or OutletID): "),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(1,0,30,0),
                                    //width: 200,
                                    child: TextField(
                                      controller: _controllers[4],
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
                                  child: RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: () async{
                                    //TODO perform sql actions here and close the screen
                                    if(_inputUsername==null ||_inputUsername=="" || _inputNewPassword==null || _inputNewPassword=="" || _inputRepeatPassword==null || _inputUserType==null || _inputUserType==""){
                                      setState(() {
                                        _errorText="Invalid/Missing details!";
                                        _errorTextColor=Colors.red;
                                        _errorTextVisible=true;

                                        _inputUsername=_controllers[0].text;
                                        _inputNewPassword=_controllers[1].text;
                                        _inputRepeatPassword=_controllers[2].text;
                                        _inputUserType=_controllers[3].text;
                                        _inputID=_controllers[4].text;
                                      });
                                      return;
                                    }
                                    else if(_inputNewPassword.compareTo(_inputRepeatPassword)!=0){
                                      setState(() {
                                        _errorText="Password fields do not match";
                                        _errorTextColor=Colors.red;
                                        _errorTextVisible=true;

                                        _inputUsername=_controllers[0].text;
                                        _inputNewPassword=_controllers[1].text;
                                        _inputRepeatPassword=_controllers[2].text;
                                        _inputUserType=_controllers[3].text;
                                        _inputID=_controllers[4].text;
                                      });
                                      return;
                                    }
                                    if(_inputID==null){
                                      _inputID="";
                                    }
                                    RequestServer server = RequestServer(action: "select * from UserTable where username=\"$_inputUsername\"", Qtype: "R");
                                    var items= await server.getDecodedResponse();
                                    if(items.toString().compareTo("Empty")==0){
                                      RequestServer serverInsert=RequestServer(action: "insert into UserTable values(\"$_inputUsername\",\"${getHashedPassword(_inputRepeatPassword)}\",\"${_inputUserType.toLowerCase()}\",\"$_inputID\")",Qtype: "W");
                                      var result=await serverInsert.getDecodedResponse();
                                      if(result.toString().compareTo("OK")==0){
                                        setState(() {
                                          _errorText="User Account Created Successfully";
                                          _errorTextColor=Colors.green;
                                          _errorTextVisible=true;
                                          for(int i=0;i<5;i++){
                                            _controllers[i].clear();
                                          }
                                        });
                                      }
                                      else{
                                        setState(() {
                                          _errorText="Something went wrong";
                                          _errorTextColor=Colors.red;
                                          _errorTextVisible=true;

                                          _inputUsername=_controllers[0].text;
                                          _inputNewPassword=_controllers[1].text;
                                          _inputRepeatPassword=_controllers[2].text;
                                          _inputUserType=_controllers[3].text;
                                          _inputID=_controllers[4].text;
                                        });
                                      }
                                    }
                                    else{
                                      setState(() {
                                        _errorText="User already exists";
                                        _errorTextColor=Colors.red;
                                        _errorTextVisible=true;

                                        _inputUsername=_controllers[0].text;
                                        _inputNewPassword=_controllers[1].text;
                                        _inputRepeatPassword=_controllers[2].text;
                                        _inputUserType=_controllers[3].text;
                                        _inputID=_controllers[4].text;
                                      });
                                    }
                                    //Navigator.pop(context);
                                  },
                                  ),

                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Visibility(
                        child: Text(_errorText,style: TextStyle(
                          color: _errorTextColor
                        ),),
                        visible: _errorTextVisible,
                      ),
                    )
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
    if(pageType==pageTypeList.transportManager){
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
    if(pageType==pageTypeList.transportManager){
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
        body: getBodyContent(),
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

