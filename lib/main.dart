import 'package:dairymanagement/adminPage.dart';
import 'package:dairymanagement/reusable/request_server.dart';
import 'package:flutter/material.dart';
import 'reusable/LogInButton.dart';
import 'reusable/multi_manager_screen.dart';
import 'package:dairymanagement/employee_manager.dart';
import 'reusable/employee_unique_screen.dart';  //tis for check
import 'reusable/const.dart'; //tis for check
import 'reusable/outlet_unique_screen.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _inputUsername,_inputPassword;
  dynamic evalStatus=userEvalStatusTypes.firstAttempt;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder:(context) => Scaffold(
          appBar: AppBar(
            title: Text("Login Page"),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO Hero Animations once other jobs are complete
                Text(
                  "Enter your username and password here",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter your username",
                  ),
                  onChanged: (string){
                    setState(() {
                      _inputUsername=string;
                      evalStatus=userEvalStatusTypes.firstAttempt;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                  ),
                  onChanged: (string){
                    setState(() {
                      _inputPassword=string;
                      evalStatus=userEvalStatusTypes.firstAttempt;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height:30,
                ),
                LoginButton(() async{
                  RequestServer server= RequestServer();
                  server.setAction("select usertype,ID from UserTable where username=$_inputUsername");
                  server.setQtype("R");
                  bool userPresent= await server.checkUserPresence(_inputUsername);
                  bool correctCredentials=await server.checkCredentials(_inputUsername, _inputPassword);
                  var response=await server.getDecodedResponse();
                  setState(() {
                    if(_inputUsername==null || _inputPassword==null){
                      evalStatus=userEvalStatusTypes.missingCredentials;
                    }
                    // else{   //AB testing else from this point
                    //   if(userPresent){
                    //     if(correctCredentials){
                    //       String usertype=response[0]['usertype'];
                    //       String ID=response[0]['ID'];
                    //       if(usertype=="employee"){
                    //         Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(builder: (context) => EmployeeUniqueScreen(_inputUsername,ID,pageTypeList.employee)
                    //                     )
                    //                 );
                    //       }
                    //       else if(usertype=="outlet"){
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => OutletUniqueScreen(ID)
                    //             )
                    //         );
                    //       }
                    //       else if(usertype=="employeemanager"){
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => EmployeeManagerScreen(_inputUsername)
                    //             )
                    //         );
                    //       }
                    //       else if(usertype=="outletmanager"){
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => MultiManagerScreen(pageTypeList.outletManager,_inputUsername)
                    //             )
                    //         );
                    //       }
                    //       else if(usertype=="procurementmanager"){
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => MultiManagerScreen(pageTypeList.procurementManager,_inputUsername)
                    //             )
                    //         );
                    //       }
                    //     }
                    //     else{
                    //       evalStatus=userEvalStatusTypes.wrongCredentials;
                    //     }
                    //   }
                    //   else{
                    //     evalStatus=userEvalStatusTypes.userDNE;
                    //   }
                    // }

//The above code is actually the one we must use but its commented because, the DB is just not ready yet







                    else if(_inputUsername=='sas047' /*Dummy condition, irl, we'll check if _inputUsername exists in the table*/){
                      if(_inputUsername=='sas047' && _inputPassword=='hello' /*Dummy condition! IRL, we'll check if _inputUsername matches _inputPassword*/){
                        evalStatus=userEvalStatusTypes.evalSuccess;
                        //Below is a dummy call for a new activity. IRL, use if-else to determine activity type for corresponding usertype
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OutletUniqueScreen("012")
                            )
                        );
                      }
                      else{
                        evalStatus=userEvalStatusTypes.wrongCredentials;
                      }
                    }
                    else{
                      evalStatus=userEvalStatusTypes.userDNE;
                    }
                  });
                },evalStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



