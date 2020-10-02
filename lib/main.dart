import 'package:dairymanagement/adminPage.dart';
import 'package:flutter/material.dart';
import 'reusable/LogInButton.dart';
import 'reusable/multi_manager_screen.dart';
import 'package:dairymanagement/employee_manager.dart';
import 'reusable/employee_unique_screen.dart';  //tis for check
import 'reusable/const.dart'; //tis for check

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  String _inputUsername,_inputPassword;
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
                    _inputUsername=string;
                    print(_inputUsername);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                  ),
                  onChanged: (string){
                    _inputPassword=string;
                    print(_inputPassword);
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height:30,
                ),
                LoginButton((){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MultiManagerScreen(pageTypeList.procurementManager))
                  );
                  //TODO verify login and open user activity
                }),
              ],
            ),
          ),
        ),
      ),
      );
  }
}



