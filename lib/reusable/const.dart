import 'package:flutter/material.dart';

String url="http://localhost:80/index.php";

enum pageTypeList{
  outletManager,
  employeeManager,
  procurementManager,
}

enum evalCredentialTypes{
  firstAttempt,
  absentCredential,
  wrongCredentials,
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