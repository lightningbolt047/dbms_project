import 'dart:async';

import 'package:dairymanagement/reusable/add_new_details.dart';
import 'package:dairymanagement/reusable/employee_unique_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'const.dart';
import 'request_server.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class OutletCard extends StatefulWidget {
  final String username,outletID;
  final Function updateParentState;
  OutletCard(this.username,this.outletID,this.updateParentState);
  @override
  _OutletCardState createState() => _OutletCardState(this.username,this.outletID,this.updateParentState);
}

class _OutletCardState extends State<OutletCard> {
  String username="",area="";
  Function updateParentState;
  String outletName="",phoneNumber="",outletID="";
  double reqMilk=0,reqYogurt=0,reqCheese=0,reqButter=0,amountPayable=0,totalIncome=0;
  _OutletCardState(this.username,this.outletID,this.updateParentState);
  String _inputPassword;

  bool populated=false;

  Future<bool> populateData() async{
    RequestServer server = RequestServer(action: "select Outlets.outID,Outlet_name,PhoneNumber,TotalIncome,AmountPayable,Area,Available.Milk,Available.Yogurt,Available.Cheese,Available.Butter,Required.Milk as ReqMilk,Required.Yogurt as ReqYogurt,Required.Cheese as ReqCheese,Required.Butter as ReqButter from Outlets,Available,Required where Outlets.outID=Available.outID and Outlets.outID=Required.outID and Outlets.outID=$outletID;", Qtype: "R");
    var items= await server.getDecodedResponse();
    if(mounted){
      setState(() {
        outletName=items[0]["Outlet_name"];
        phoneNumber=items[0]["PhoneNumber"];
        outletID=items[0]["outID"];
        area=items[0]["Area"];
        amountPayable=double.parse(items[0]["AmountPayable"]);
        reqButter=double.parse(items[0]["ReqButter"]);
        reqCheese=double.parse(items[0]["ReqCheese"]);
        reqMilk=double.parse(items[0]["ReqMilk"]);
        reqYogurt=double.parse(items[0]["ReqYogurt"]);
        totalIncome=double.parse(items[0]["TotalIncome"]);
        populated=true;
      });
    }
    return true;
  }

  bool authorized=true;


  Color getDeliverStockButtonColor(){
    if(authorized==false){
      return Colors.red;
    }
    else{
      return Colors.blueAccent;
    }
  }

  String getDeliverStockText(){
    if((reqMilk+reqCheese+reqYogurt+reqButter)==0){
      return "Stocks Delivered";
    }
    if(authorized==false){
      return "You are not authorized";
    }
    else{
      return "Deliver Stocks";
    }
  }

  Function getDeliverStockFunction(){
      return () async{
        final _returnedData= await showModalBottomSheet(context: context, builder:(context){
          return PasswordConfirm();  //Temp testing
        });
        if(_returnedData==null){
          setState(() {
            authorized=false;
          });
          Timer(const Duration(seconds: 10),(){
            setState(() {
              authorized=true;
            });
          });
          return;
        }
        RequestServer server=RequestServer();
        bool authStatus=await server.checkCredentials(username, _returnedData);
        if(authStatus){
          RequestServer server=RequestServer(action: "select * from CurrentAvailability where onDate=\"${dates[date]}\"",Qtype: "R");
          var items= await server.getDecodedResponse();
          double curMilk,curButter,curCheese,curYogurt;
          curMilk=double.parse(items[0]['Milk']);
          curButter=double.parse(items[0]['Butter']);
          curCheese=double.parse(items[0]['Cheese']);
          curYogurt=double.parse(items[0]['Yogurt']);

          double orderMilk,orderButter,orderCheese,orderYogurt;

          if(curMilk<reqMilk){
            orderMilk=curMilk;
          }
          else{
            orderMilk=reqMilk;
          }

          if(curButter<reqButter){
            orderButter=curButter;
          }
          else{
            orderButter=reqButter;
          }

          if(curCheese<reqCheese){
            orderCheese=curCheese;
          }
          else{
            orderCheese=reqCheese;
          }

          if(curYogurt<reqYogurt){
            orderYogurt=curYogurt;
          }
          else{
            orderYogurt=reqYogurt;
          }
          curMilk-=orderMilk;
          curButter-=orderButter;
          curCheese-=orderCheese;
          curYogurt-=orderYogurt;

          server.setAction("UPDATE CurrentAvailability SET Milk=$curMilk,Yogurt=$curYogurt,Cheese=$curCheese,Butter=$curButter where onDate=\"${dates[date]}\"");
          server.setQtype("W");
          var response=await server.getDecodedResponse();

          server.setAction("select * from Available where outID=\"$outletID\"");
          server.setQtype("R");

          var items1=await server.getDecodedResponse();

          double availMilk,availButter,availYogurt,availCheese;
          availMilk=double.parse(items1[0]['Milk']);
          availButter=double.parse(items1[0]['Butter']);
          availCheese=double.parse(items1[0]['Cheese']);
          availYogurt=double.parse(items1[0]['Yogurt']);

          availMilk+=orderMilk;
          availButter+=orderButter;
          availCheese+=orderCheese;
          availYogurt+=orderYogurt;

          server.setAction("UPDATE Available SET Milk=$availMilk,Yogurt=$availYogurt,Cheese=$availCheese,Butter=$availButter where outID=\"$outletID\"");
          server.setQtype("W");
          var response1=await server.getDecodedResponse();
          server.setAction("select * from Required where outID=\"$outletID\"");
          server.setQtype("R");
          var items2=await server.getDecodedResponse();
          double curReqMilk,curReqButter,curReqCheese,curReqYogurt;
          curReqMilk=double.parse(items2[0]['Milk'])-orderMilk;
          curReqButter=double.parse(items2[0]['Butter'])-orderButter;
          curReqCheese=double.parse(items2[0]['Cheese'])-orderCheese;
          curReqYogurt=double.parse(items2[0]['Yogurt'])-orderYogurt;
          server.setAction("UPDATE Required SET Milk=$curReqMilk,Yogurt=$curReqYogurt,Cheese=$curReqCheese,Butter=$curReqButter where outID=\"$outletID\"");
          server.setQtype("W");
          var response2=await server.getDecodedResponse();
          if(response.toString().compareTo("OK")==0 && response1.toString().compareTo("OK")==0 && response2.toString().compareTo("OK")==0){
            setState(() {
              reqMilk-=orderMilk;
              reqCheese-=orderCheese;
              reqYogurt-=orderYogurt;
              reqButter-=orderButter;
              print("Stocks Delivered");
              populated=false;
            });
            populateData();
            updateParentState();
          }
          else{
            print(response.toString());
          }
        }
        else{
          setState(() {
            authorized=false;
          });
          Timer(const Duration(seconds: 10),(){
            setState(() {
              authorized=true;
            });
          });
        }
      };
  }

  // String getAmountPayText(){
  //   if(amountPayable==0){
  //     return "Paid ✅";
  //   }
  //   else{
  //     return "Pay $amountPayable";
  //   }
  // }

  // Function getAmountPayFunction(){
  //   return () async{
  //
  //     /*Navigator.push(context,
  //     MaterialPageRoute(builder: (context)=> PasswordConfirm()));*/
  //     final _returnedData= await showModalBottomSheet(context: context, builder:(context){
  //       return PasswordConfirm();  //Temp testing
  //     });
  //     _inputPassword=_returnedData;
  //     print(_inputPassword);  //This is temporary, we will do work with it
  //     setState(() {
  //       amountPayable=0;
  //     });
  //
  //   };
  // }

  @override
  void initState() {
    populateData();
    super.initState();
  }

  double getProgressBarPercentValue(double number){
    if(number>500){
      return 1;
    }
    return number/500;
  }

  @override
  Widget build(BuildContext context) {
    if(populated==false){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                      "$outletName, $area",
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
                    Row(
                      children: [
                        Text(
                          "Required Milk: ",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Container(
                            width: 50,
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value: 1-getProgressBarPercentValue(reqMilk),
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("$reqMilk"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Required Butter: ",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Container(
                            width: 50,
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              backgroundColor: Colors.yellowAccent,
                              value: 1-getProgressBarPercentValue(reqButter),
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.yellow),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("$reqButter"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Required Cheese: ",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Container(
                            width: 50,
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value: 1-getProgressBarPercentValue(reqCheese),
                              backgroundColor: Colors.lightGreenAccent,
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("$reqCheese"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Required Yogurt: ",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Container(
                            width: 50,
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value: 1-getProgressBarPercentValue(reqYogurt),
                              backgroundColor: Color(0xff66b3cc),
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("$reqYogurt"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        FlatButton(
                          color: getDeliverStockButtonColor(),
                          textColor: Colors.white,
                          child: Text(getDeliverStockText()),
                          onPressed: ((reqMilk+reqCheese+reqYogurt+reqButter)==0)?null:getDeliverStockFunction() ,
                        ),
                        // sizedBoxLargeInRow,
                        // FlatButton(
                        //   color: Colors.blueAccent,
                        //   textColor: Colors.white,
                        //   child: Text(getAmountPayText()),
                        //   onPressed: (amountPayable==0)?null:getAmountPayFunction(),
                        // ),
                      ],
                    )
                  ],
                ),
              )
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final String id, username,name, phoneNumber;
  EmployeeCard(this.username,this.id, this.name, this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return EmployeeUniqueScreen(username,id,pageTypeList.employeeManager);
        }));
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
                  Icons.drive_file_rename_outline,
                  size: 20,
                ),
                sizedBoxSmallInRow,
                Text(name),
                SizedBox(
                  width: 5,
                ),
                sizedBoxLargeInRow,
                Icon(
                  Icons.perm_identity,
                  size:20
                ),
                sizedBoxSmallInRow,
                Text(id),
                sizedBoxLargeInRow,
                phoneIcon,
                sizedBoxSmallInRow,
                Text(phoneNumber),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MilkProducerCard extends StatefulWidget {

  final String username,producerID;

  MilkProducerCard(this.username,this.producerID);
  @override
  _MilkProducerCardState createState() => _MilkProducerCardState(this.username,this.producerID);
}

class _MilkProducerCardState extends State<MilkProducerCard> {
  String username="",name="",producerID="",area="",phoneNumber="";
  double amountPayable=0,getMilk=0,givenMilk;

  bool authorized=true;

  _MilkProducerCardState(this.username,this.producerID);

  Future<bool> populateData() async{
    RequestServer server = RequestServer(action: "select * from MilkProducer where ProducerID=$producerID", Qtype: "R");
    var items= await server.getDecodedResponse();
    if(mounted){
      setState(() {
        name=items[0]["Name"];
        phoneNumber=items[0]["PhoneNumber"];
        area=items[0]["Area"];
        amountPayable=double.parse(items[0]["AmountPayable"]);
        givenMilk=double.parse(items[0]["Litres"]);
      });
    }
    return true;
  }



  Function getAmountPayFunction(){
    return () async{
      final _returnedData= await showModalBottomSheet(context: context, builder:(context){
        return PasswordConfirm();  //Temp testing
      });
      if(_returnedData==null){
        setState(() {
          authorized=false;
        });
        Timer(const Duration(seconds: 10),(){
          setState(() {
            authorized=true;
          });
        });
        return;
      }
      RequestServer server=RequestServer();
      bool authStatus=await server.checkCredentials(username, _returnedData);
      if(authStatus){
        RequestServer server=RequestServer(action: "UPDATE Expenses SET Amount+=$amountPayable where onDate=\"${dates[date]}\"",Qtype: "W");
        var response=await server.getDecodedResponse();
        server.setAction("UPDATE NetAmount SET Expense+=$amountPayable where onDate=\"${dates[date]}\"");
        var response1=await server.getDecodedResponse();
        server.setAction("UPDATE NetAmount SET Profit=Income-Expense where onDate=\"${dates[date]}\"");
        var response2=await server.getDecodedResponse();
        server.setAction("UPDATE MilkProducer SET AmountPayable=0 where ProducerID=\"$producerID\"");
        var response3=await server.getDecodedResponse();
        if(response.toString().compareTo("OK")==0 && response1.toString().compareTo("OK")==0 && response2.toString().compareTo("OK")==0 && response3.toString().compareTo("OK")==0){
          setState(() {
            amountPayable=0;
          });
        }
      }
      else{
        setState(() {
          authorized=false;
        });
        Timer(const Duration(seconds: 10),(){
          setState(() {
            authorized=true;
          });
        });
      }
    };
  }

  String getAmountPayButtonText(){
    if(amountPayable==0){
      return "Amount Paid";
    }
    if(authorized==false){
      return "You are not Authorized";
    }
    else{
      return "Pay Producer: $amountPayable";
    }
  }

  Color getAmountPayButtonColor(){
    if(authorized){
      return Colors.blueAccent;
    }
    else{
      return Colors.red;
    }
  }

  @override
  void initState(){
    populateData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if(name==""){
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                name,
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
                  Text(producerID),
                ],
              ),
              sizedBoxInColumn,
              Text(
                "Area: $area"
              ),
              Row(
                children: [
                  Text(
                    "Get Milk: $getMilk",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action:(){
                      setState(() {
                        if(getMilk<50000){
                          getMilk+=1000;
                        }
                      });
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action:(){
                      setState(() {
                        if(getMilk>0){
                          getMilk-=500;
                        }
                      });
                    }),
                  ),
                ],
              ),
              Text(
                "Procured Milk: $givenMilk"
              ),
              Row(
                children: [
                  FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text("Procure Milk"),
                    onPressed: () async{
                      RequestServer server=RequestServer(action: "select Litres, Amount from MilkProducer where ProducerID=\"$producerID\"",Qtype: "R");
                      var items=await server.getDecodedResponse();
                      double litres=double.parse(items[0]['Litres']);
                      double amount=double.parse(items[0]['Amount']);
                      litres+=getMilk;
                      amountPayable+=getMilk*procureMilkRate;
                      amount+=getMilk*procureMilkRate;
                      server.setAction("UPDATE MilkProducer SET Litres=$litres,Amount=$amount,AmountPayable=$amountPayable where ProducerID=\"$producerID\"");
                      server.setQtype("W");
                      var response=await server.getDecodedResponse();
                      server.setAction("select Name,QtyProduced from Product natural join Conversion order by PID;");
                      server.setQtype("R");
                      var items1=await server.getDecodedResponse();
                      double milk2milk=getMilk*(double.parse(items1[0]['QtyProduced']));
                      double milk2butter=getMilk*(double.parse(items1[1]['QtyProduced']));
                      double milk2cheese=getMilk*(double.parse(items1[2]['QtyProduced']));
                      double milk2yogurt=getMilk*(double.parse(items1[3]['QtyProduced']));
                      
                      server.setAction("UPDATE CurrentAvailability SET Milk=$milk2milk,Yogurt=$milk2yogurt,Cheese=$milk2cheese,Butter=$milk2butter where onDate=\"${dates[date]}\"");
                      server.setQtype("W");
                      var response1=await server.getDecodedResponse();
                      if(response.toString().compareTo("OK")==0 && response1.toString().compareTo("OK")==0){
                        setState(() {
                          givenMilk+=getMilk;
                          getMilk=0;
                          print("Update success");
                        });
                        return;
                      }
                    } ,
                  ),
                  sizedBoxLargeInRow,
                  FlatButton(
                    color: getAmountPayButtonColor(),
                    textColor: Colors.white,
                    child: Text(getAmountPayButtonText()),
                    onPressed: (amountPayable!=0)?getAmountPayFunction():null,
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

class Transport extends StatefulWidget {
  final String truckID;
  Transport(this.truckID);
  @override
  _TransportState createState() => _TransportState(this.truckID);
}

class _TransportState extends State<Transport> {
  String truckID="",area="";
  String numberPlate="",empID="";
  _TransportState(this.truckID);


  Future<bool> populateData() async{
    RequestServer server = RequestServer(action: "select Transport.TruckID,NumberPlate,EmpID,Area from Truck,Transport where Transport.TruckID=$truckID and Transport.TruckID=Truck.TruckID;", Qtype: "R");
    var items= await server.getDecodedResponse();
    if(mounted){
      setState(() {
        numberPlate=items[0]["NumberPlate"];
        empID=items[0]["EmpID"];
        area=items[0]["Area"];
      });
    }
    return true;
  }



  @override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(numberPlate==""){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                  "$truckID, $area",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                sizedBoxInColumn,
                Row(
                  children: [
                    Icon(
                        FontAwesomeIcons.car
                    ),
                    sizedBoxSmallInRow,
                    Text(
                      numberPlate,
                    ),
                    sizedBoxLargeInRow,
                    idIcon,
                    sizedBoxSmallInRow,
                    Text(empID),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

