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

  String _empID,_empName,_phoneNumber,_job,_dateOfJoin,_address;
  double _salary,_amountPayable=0;

  double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;

  String _outletName,_outletPhoneNumber,_area,_outletID;

  String _inputUsername,_inputID,_inputNewPassword,_inputRepeatPassword,_inputUserType;

  String _producerName,_producerID,_producerPhoneNumber,_producerArea;

  String _truckID,_truckArea,_truckNumberPlate,_truckEmpID;

  _AddDetailsState(this.pageType);

  dynamic getBodyContent(){
    if(pageType==pageTypeList.employeeManager){
      for(int i=0;i<7;i++){
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
                    Text("Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          controller: _controllers[0],
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
                        controller: _controllers[1],
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
                          controller: _controllers[2],
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
                          controller: _controllers[3],
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
                          controller: _controllers[4],
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
                          controller: _controllers[5],
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
                          controller: _controllers[6],
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
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: () async{
                      if(_empID==null || _empID=="" || _empName==null || _empName=="" || double.tryParse(_phoneNumber)==null || _job==null || _job=="" || _dateOfJoin==null || _dateOfJoin=="" || _address==null || _address=="" || _salary==null){
                        setState(() {
                          _errorText="Invalid/Missing details! Tip: Make sure PhoneNumber and Salary are just numbers";
                          _errorTextColor=Colors.red;
                          _errorTextVisible=true;

                          _empName=_controllers[0].text;
                          _phoneNumber=_controllers[1].text;
                          _empID=_controllers[2].text;
                          _job=_controllers[3].text;
                          _dateOfJoin=_controllers[4].text;
                          _address=_controllers[5].text;
                          _salary=double.tryParse(_controllers[6].text);
                        });
                        return;
                      }
                      RequestServer server = RequestServer(action: "select EmpID from Employees where EmpID=\"$_empID\"", Qtype: "R");
                      var items= await server.getDecodedResponse();
                      if(items.toString().compareTo("Empty")==0){
                        RequestServer serverInsert=RequestServer(action: "insert into Employees values(\"$_empID\",\"$_empName\",\"$_phoneNumber\",\"$_job\",\"$_dateOfJoin\",$_salary,${_salary*0.5},\"$_address\")",Qtype: "W");
                        var result=await serverInsert.getDecodedResponse();
                        if(result.toString().compareTo("OK")==0){
                          setState(() {
                            _errorText="Employee entry Created Successfully";
                            _errorTextColor=Colors.green;
                            _errorTextVisible=true;
                            for(int i=0;i<7;i++){
                              _controllers[i].clear();
                            }
                          });
                          Navigator.pop(context);
                        }
                        else{
                          setState(() {
                            _errorText="Something went wrong. Tip: Make sure the Date is in YYYY-MM-DD format";
                            _errorTextColor=Colors.red;
                            _errorTextVisible=true;

                            _empName=_controllers[0].text;
                            _phoneNumber=_controllers[1].text;
                            _empID=_controllers[2].text;
                            _job=_controllers[3].text;
                            _dateOfJoin=_controllers[4].text;
                            _address=_controllers[5].text;
                            _salary=double.tryParse(_controllers[6].text);
                          });
                        }
                      }
                      else{
                        setState(() {
                          _errorText="Employee already exists";
                          _errorTextColor=Colors.red;
                          _errorTextVisible=true;

                          _empName=_controllers[0].text;
                          _phoneNumber=_controllers[1].text;
                          _empID=_controllers[2].text;
                          _job=_controllers[3].text;
                          _dateOfJoin=_controllers[4].text;
                          _address=_controllers[5].text;
                          _salary=double.tryParse(_controllers[6].text);
                        });
                      }

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
                    Text("Name: "),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1,0,30,0),
                        //width: 200,
                        child: TextField(
                          controller: _controllers[0],
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
                          controller: _controllers[1],
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
                          controller: _controllers[2],
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
                          controller: _controllers[3],
                          decoration: InputDecoration(
                            labelText: "Producer's Area (lower case)",
                          ),
                          onChanged: (string){
                            _producerArea=string;
                          },
                        ),
                      ),
                    ),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: () async{
                      if(_producerID==null || _producerID=="" || _producerArea==null || _producerArea=="" || _producerPhoneNumber==null || _producerPhoneNumber=="" || _producerName==null || _producerName==""){
                        setState(() {
                          _errorText="Invalid/Missing details!";
                          _errorTextColor=Colors.red;
                          _errorTextVisible=true;

                          _producerName=_controllers[0].text;
                          _producerPhoneNumber=_controllers[1].text;
                          _producerID=_controllers[2].text;
                          _producerArea=_controllers[3].text;
                        });
                        return;
                      }
                      RequestServer server = RequestServer(action: "select ProducerID from MilkProducer where ProducerID=\"$_producerID\"", Qtype: "R");
                      var items= await server.getDecodedResponse();
                      if(items.toString().compareTo("Empty")==0){
                        RequestServer serverInsert=RequestServer(action: "insert into MilkProducer values(\"$_producerID\",\"$_producerName\",\"$_producerArea\",\"$_producerPhoneNumber\",0,0,0)",Qtype: "W");
                        var result=await serverInsert.getDecodedResponse();
                        if(result.toString().compareTo("OK")==0){
                          setState(() {
                            _errorText="New Producer entry created Successfully";
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
                            _errorText="Something went wrong. Tip: An Area can be entered only if it is being served";
                            _errorTextColor=Colors.red;
                            _errorTextVisible=true;

                            _producerName=_controllers[0].text;
                            _producerPhoneNumber=_controllers[1].text;
                            _producerID=_controllers[2].text;
                            _producerArea=_controllers[3].text;
                          });
                        }
                      }
                      else{
                        setState(() {
                          _errorText="Producer already exists";
                          _errorTextColor=Colors.red;
                          _errorTextVisible=true;

                          _producerName=_controllers[0].text;
                          _producerPhoneNumber=_controllers[1].text;
                          _producerID=_controllers[2].text;
                          _producerArea=_controllers[3].text;
                        });
                      }
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
    if(pageType==pageTypeList.transportManager){
      for(int i=0;i<4;i++){
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
                          Text("TruckID: "),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1,0,30,0),
                              //width: 200,
                              child: TextField(
                                controller: _controllers[0],
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
                                controller: _controllers[1],
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
                                controller: _controllers[2],
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
                                      controller: _controllers[3],
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
                                  child: RoundActionButton(child: Icon(FontAwesomeIcons.check,color: Colors.white,),action: () async{
                                    if(_truckID==null || _truckID=="" || _truckArea==null || _truckArea=="" || _truckNumberPlate==null || _truckNumberPlate=="" || _truckEmpID==null || _truckEmpID==""){
                                      setState(() {
                                        _errorText="Invalid/Missing details!";
                                        _errorTextColor=Colors.red;
                                        _errorTextVisible=true;

                                        _truckID=_controllers[0].text;
                                        _truckEmpID=_controllers[1].text;
                                        _truckNumberPlate=_controllers[2].text;
                                        _truckArea=_controllers[3].text;
                                      });
                                      return;
                                    }
                                    RequestServer server = RequestServer(action: "select TruckID from Truck where TruckID=\"$_truckID\"", Qtype: "R");
                                    var items= await server.getDecodedResponse();
                                    server.setAction("select EmpID from Employees where EmpID=\"$_truckEmpID\"");
                                    server.setQtype("R");
                                    var items1= await server.getDecodedResponse();
                                    server.setAction("select Area from Transport where Area=\"${_truckArea.toLowerCase()}\"");
                                    server.setQtype("R");
                                    var items2=await server.getDecodedResponse();
                                    if(items.toString().compareTo("Empty")==0 && items1.toString().compareTo("Empty")!=0 && items2.toString().compareTo("Empty")==0){
                                      RequestServer serverInsert=RequestServer(action: "insert into Truck values(\"$_truckID\",\"$_truckNumberPlate\",\"$_truckEmpID\")",Qtype: "W");
                                      var result=await serverInsert.getDecodedResponse();
                                      serverInsert.setAction("insert into Transport values(\"$_truckID\",\"${_truckArea.toLowerCase()}\")");
                                      var result1=await serverInsert.getDecodedResponse();
                                      if(result.toString().compareTo("OK")==0 && result1.toString().compareTo("OK")==0){
                                        setState(() {
                                          _errorText="New Truck entry created Successfully";
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

                                          _truckID=_controllers[0].text;
                                          _truckEmpID=_controllers[1].text;
                                          _truckNumberPlate=_controllers[2].text;
                                          _truckArea=_controllers[3].text;
                                        });
                                      }
                                    }
                                    else{
                                      setState(() {
                                        _errorText="Error: Check if Truck or Area is already being served and be sure to input EmpID of only an employee";
                                        _errorTextColor=Colors.red;
                                        _errorTextVisible=true;

                                        _truckID=_controllers[0].text;
                                        _truckEmpID=_controllers[1].text;
                                        _truckNumberPlate=_controllers[2].text;
                                        _truckArea=_controllers[3].text;
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
      return "Create and Assign Truck to driver";
    }
    return "Non Null AppBar name to keep from crashing😂";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: screenHeadFont),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(FontAwesomeIcons.powerOff,color: Colors.white,),
              ),
            )
          ],
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
      theme: ThemeData(fontFamily: screenHeadFont),
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

