import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function function;
  final color;
  final text;
  LoginButton(this.function,this.color,this.text);
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
          child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
        ),
      ),
      onTap: function,
    );
  }
}
