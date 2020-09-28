import 'package:flutter/material.dart';
import 'const.dart';


class outletCard extends StatefulWidget {
  String outletName,phoneNumber,outletID;
  double reqMilk,reqYogurt,reqCheese,reqButter,amountPayable,totalIncome;
  outletCard(this.outletName,this.amountPayable,this.phoneNumber,this.reqButter,this.reqCheese,this.reqMilk,this.reqYogurt,this.totalIncome,this.outletID);
  @override
  _outletCardState createState() => _outletCardState(this.outletName,this.amountPayable,this.phoneNumber,this.reqButter,this.reqCheese,this.reqMilk,this.reqYogurt,this.totalIncome,this.outletID);
}

class _outletCardState extends State<outletCard> {
  String outletName,phoneNumber,outletID;
  double reqMilk,reqYogurt,reqCheese,reqButter,amountPayable,totalIncome;
  _outletCardState(this.outletName,this.amountPayable,this.phoneNumber,this.reqButter,this.reqCheese,this.reqMilk,this.reqYogurt,this.totalIncome,this.outletID);

  String getDeliverStockText(){
    if((reqMilk+reqCheese+reqYogurt+reqButter)==0){
      return "Stocks Delivered";
    }
    else{
      return "Deliver Stocks";
    }
  }

  Function getDeliverStockFunction(){
      return (){
        setState(() {
          //TODO Perform Sql for delivery
          reqMilk=reqCheese=reqYogurt=reqButter=0;
          print("Stocks Delivered");
        });
      };
  }

  String getAmountPayText(){
    if(amountPayable==0){
      return "Paid ✅";
    }
    else{
      return "Pay $amountPayable";
    }
  }

  Function getAmountPayFunction(){
    return (){
      setState(() {
        //TODO Perform sql functions here
        amountPayable=0;
      });
    };
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                outletName,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              sizedBoxInColumn,
              Row(
                children: [
                  phoneIcon,
                  sizedBoxSmallInRow,
                  Text(
                      phoneNumber,
                  ),
                  sizedBoxLargeInRow,
                  idIcon,
                  sizedBoxSmallInRow,
                  Text(outletID),
                ],
              ),
              Text(
                  "Required Milk: $reqMilk",
              ),
              Text(
                  "Required Yogurt: $reqYogurt",
              ),
              Text(
                  "Required Butter: $reqButter",
              ),
              Text(
                  "Required Cheese: $reqCheese",
              ),
              Row(
                children: [
                  FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text(getDeliverStockText()),
                    onPressed: ((reqMilk+reqCheese+reqYogurt+reqButter)==0)?null:getDeliverStockFunction() ,
                  ),
                  sizedBoxLargeInRow,
                  FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text(getAmountPayText()),
                    onPressed: (amountPayable==0)?null:getAmountPayFunction(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final String id, name;
  EmployeeCard(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO open employee unique screen with relevant details
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.perm_identity,
                  size: 20,
                ),
                sizedBoxSmallInRow,
                Text(name),
                SizedBox(
                  width: 5,
                ),
                Text("LastName"),
                sizedBoxLargeInRow,
                phoneIcon,
                sizedBoxSmallInRow,
                Text(id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
