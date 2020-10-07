import 'package:flutter/material.dart';
import 'package:dairymanagement/reusable/const.dart';
import 'package:dairymanagement/employee_manager.dart';
import 'employee_unique_screen.dart';
import 'multi_manager_screen.dart';
import 'request_server.dart';

class LoginButton extends StatefulWidget {
  BuildContext context;
  String _inputUsername,_inputPassword;
  LoginButton(this.context,this._inputUsername,this._inputPassword);
  @override
  _LoginButtonState createState() => _LoginButtonState(this.context,this._inputUsername,this._inputPassword);
}

class _LoginButtonState extends State<LoginButton> {
  BuildContext context;
  String _inputUsername,_inputPassword;
  _LoginButtonState(this.context,this._inputUsername,this._inputPassword);

  dynamic evalStatus=userEvalStatuses.firstAttempt;

  Color getButtonColor(){
    if(evalStatus==userEvalStatuses.firstAttempt){
      return Colors.blueAccent;
    }
    else{
      return Colors.redAccent;
    }
  }

  String getButtontext(){
    if(evalStatus==userEvalStatuses.firstAttempt || evalStatus==userEvalStatuses.evalSuccess){
      return "Log In";
    }
    if(evalStatus==userEvalStatuses.missingCredentials){
      return "Username or Password empty! Try again";
    }
    if(evalStatus==userEvalStatuses.wrongCredentials){
      return "Wrong username and password! Try again";
    }
    return 'Non null String';
  }

  Function getEvalFunction(){
    return (){
      setState(() {
        print("Final uname: $_inputUsername");
        print("Final pass: $_inputPassword");
        //TODO evaluate using SQL queries!
        //Dummy test
        if(_inputUsername==null || _inputPassword==null){
          evalStatus=userEvalStatuses.missingCredentials;
        }
        //TODO here is where SQL query and evaluation happens
        else if(_inputUsername=="sas047" || _inputPassword=="hello"){
          evalStatus=userEvalStatuses.evalSuccess;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmployeeManagerScreen())
          );
        }
        else{
          evalStatus=userEvalStatuses.wrongCredentials;
        }
      });
    };

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: getButtonColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getButtontext(),style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
      onTap: getEvalFunction(),
    );
  }
}

