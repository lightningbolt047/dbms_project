import 'dart:developer';

import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function function;
  final dynamic evalStatus;
  LoginButton(this.function,this.evalStatus);

  String getButtonText(){
    if(evalStatus==userEvalStatusTypes.firstAttempt || evalStatus==userEvalStatusTypes.evalSuccess){
      return "Log In";
    }
    else if(evalStatus==userEvalStatusTypes.missingCredentials){
      return "Missing credential(s)! Try Again";
    }
    else if(evalStatus==userEvalStatusTypes.userDNE) {
      return "User does not exist";
    }
    else if(evalStatus==userEvalStatusTypes.wrongCredentials){
      return "Wrong username and password! Try Again";
    }
    return "Non null String";
  }

  Color getButtonColor(){
    if(evalStatus==userEvalStatusTypes.firstAttempt || evalStatus==userEvalStatusTypes.evalSuccess){
      return Colors.blueAccent;
    }
    else if(evalStatus==userEvalStatusTypes.wrongCredentials || evalStatus==userEvalStatusTypes.missingCredentials || evalStatus==userEvalStatusTypes.userDNE){
      return Colors.redAccent;
    }
    else{
      return Colors.blueGrey;
    }
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
          child: Text(getButtonText(),style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
      onTap: function,
    );
  }
}
