import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function function;
  LoginButton(this.function);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Log In",style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
      onTap: function,
    );
  }
}
