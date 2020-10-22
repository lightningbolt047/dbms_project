import 'package:flutter/material.dart';

String url="http://localhost:80/index.php";

enum pageTypeList{
  outletManager,
  employeeManager,
  procurementManager,
  employee,
  admin,
  transport
}

List dates=["2020-10-08","2020-10-09","2020-10-10","2020-10-11","2020-10-12","2020-10-13","2020-10-14","2020-10-15","2020-10-16"];

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

double milkRate=35;
double butterRate=60;
double cheeseRate=65;
double yogurtRate=40;

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
