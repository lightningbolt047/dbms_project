import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable/const.dart';
import 'reusable/request_server.dart';

class FinanceManagerScreen extends StatefulWidget {
  @override
  _FinanceManagerScreenState createState() => _FinanceManagerScreenState();
}

class _FinanceManagerScreenState extends State<FinanceManagerScreen> {
  double incomeAmount=-999,incomeTax=0,netIncome=0;
  double expense=0;
  double netProfit=0;
  bool populated;


  Future<bool> populateData() async{
    String onDate=dates[date];
    RequestServer server = RequestServer(action: "select * from Income where onDate=\"$onDate\"", Qtype: "R");
    var items= await server.getDecodedResponse();
    RequestServer server1 = RequestServer(action: "select * from Expenses where onDate=\"$onDate\"",Qtype: "R");
    var items1=await server1.getDecodedResponse();
    setState(() {
      incomeAmount=double.parse(items[0]["Amount"]);
      incomeTax=double.parse(items[0]["Tax"]);
      netIncome=double.parse(items[0]["NetAmount"]);
      expense=double.parse(items1[0]["Amount"]);
    });
    populated=true;
    return true;
  }


  void calculateProfit(){
    if(netIncome>expense){
      netProfit=netIncome-expense;
    }
    else{
      netProfit=expense-netIncome;
    }
    return;
  }

  Color getProfitNumberColor(){
    if(expense>netIncome){
      return Colors.red;
    }
    else if(netIncome>expense){
      return Colors.green;
    }
    return Colors.blueGrey;
  }

  String getProfitDescText(){
    if(expense>netIncome){
      return "Loss:  ${((netProfit*100)/expense).toStringAsPrecision(5)}%";
    }
    else if(netIncome>expense){
      return "Profit: ${((netProfit*100)/expense).toStringAsPrecision(5)}%";
    }
    else{
      return "No Profit No Loss";
    }
  }

@override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(populated==false){
      populateData();
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if(populated==null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    calculateProfit();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Finance Status"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: GestureDetector(
                child: Icon(FontAwesomeIcons.powerOff),
                onTap:(){
                  Navigator.pop(context);
                }
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Date: "+dates[date],
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$netIncome",style: TextStyle(
                              color: Colors.green,
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                            ),),
                            Text("Net Income",style: TextStyle(
                              color: Colors.green,
                              fontSize: 25
                            ),),
                            sizedBoxInColumn,
                            sizedBoxInColumn,
                            Text("Actual Income: $incomeAmount",style: TextStyle(
                              fontSize: 25,
                              color: Colors.green
                            ),),
                            Text("Tax: $incomeTax",style: TextStyle(
                              fontSize: 25,
                              color: Colors.red
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$expense",style: TextStyle(
                              color: Colors.red,
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                            ),),
                            sizedBoxInColumn,
                            sizedBoxInColumn,
                            Text("Spent on the day",style: TextStyle(
                              color:Colors.red,
                              fontSize: 25,
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50,8,50,8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Net Result",style: TextStyle(
                        color: getProfitNumberColor(),
                        fontSize: 25,
                      ),),
                      Text("$netProfit",style: TextStyle(
                        color: getProfitNumberColor(),
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(getProfitDescText(),style: TextStyle(
                        color: getProfitNumberColor(),
                        fontSize: 25
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                    setState(() {
                      if(date>0){
                        date--;
                        populated=false;
                      }
                    });
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                    setState(() {
                      if(date<dates.length-1){
                        date++;
                        populated=false;
                      }
                    });
                  },),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

