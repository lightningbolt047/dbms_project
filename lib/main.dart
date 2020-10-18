import 'package:dairymanagement/adminPage.dart';
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
                LoginButton((){
                  setState(() {
                    if(_inputUsername==null || _inputPassword==null){
                      evalStatus=userEvalStatusTypes.missingCredentials;
                    }
                    else if(_inputUsername=='sas047' /*Dummy condition, irl, we'll check if _inputUsername exists in the table*/){
                      if(_inputUsername=='sas047' && _inputPassword=='hello' /*Dummy condition! IRL, we'll check if _inputUsername matches _inputPassword*/){
                        evalStatus=userEvalStatusTypes.evalSuccess;
                        //Below is a dummy call for a new activity. IRL, use if-else to determine activity type for corresponding usertype
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OutletUniqueScreen()
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



