import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

String url="http://localhost:80/index.php";

enum pageTypeList{
  outletManager,
  employeeManager,
  procurementManager,
  employee,
  admin,
  transportManager,
  financeManager
}

List dates=["2020-10-08","2020-10-09","2020-10-10","2020-10-11","2020-10-12","2020-10-13","2020-10-14"];
var date=1;

String screenHeadFont='Acme';
String screenContentFont='Sriracha';
String screenTertiaryFont='ShadowsIntoLight';

enum userEvalStatusTypes{
  firstAttempt,
  missingCredentials,
  wrongCredentials,
  userDNE,
  evalSuccess
}

var phoneIcon=Icon(
  Icons.phone,
  size: 15,
);

var sizedBoxSmallInRow = SizedBox(
  width: 10,
);

var sizedBoxLargeInRow = SizedBox(
  width: 25,
);

var sizedBoxVeryLargeInRow = SizedBox(
  width: 200,
);
var idIcon = Icon(
  Icons.perm_identity_sharp,
  size: 15,
);

var sizedBoxInColumn = SizedBox(
  height: 10,
);

double saleMilkRate=35;
double saleButterRate=60;
double saleCheeseRate=65;
double saleYogurtRate=40;

double procureMilkRate=15;

double tax=0.4;

class RoundActionButton extends StatelessWidget {
  final Widget child;
  final Function action;
  RoundActionButton({@required this.child, this.action});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      shape: CircleBorder(),
      onPressed: action,
      fillColor: Colors.blueAccent,
      elevation: 5,
      constraints: BoxConstraints.tightFor(
        height:35.0,
        width: 35.0,
      ),
    );
  }
}

class CustomRoundActionButton extends StatelessWidget {
  final Widget child;
  final Function action;
  final Color color;
  CustomRoundActionButton({@required this.child,this.color, this.action});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      shape: CircleBorder(),
      onPressed: action,
      fillColor: color,
      elevation: 5,
      constraints: BoxConstraints.tightFor(
        height:35.0,
        width: 35.0,
      ),
    );
  }
}

String getHashedPassword(String password){
  var bytes=utf8.encode(password);
  var digest=md5.convert(bytes);
  return digest.toString();
}