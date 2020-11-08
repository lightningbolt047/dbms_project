import 'package:dairymanagement/reusable/add_new_details.dart';
import 'package:dairymanagement/reusable/employee_unique_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'const.dart';
import 'request_server.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class OutletCard extends StatefulWidget {
  String username,outletID;
  OutletCard(this.username,this.outletID);
  @override
  _OutletCardState createState() => _OutletCardState(this.username,this.outletID);
}

class _OutletCardState extends State<OutletCard> {
  String username="",area="";
  String outletName="",phoneNumber="",outletID="";
  double reqMilk=0,reqYogurt=0,reqCheese=0,reqButter=0,amountPayable=0,totalIncome=0;
  _OutletCardState(this.username,this.outletID);
  String _inputPassword;



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
      });
    }
    return true;
  }

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
    return () async{
        //TODO Invoke password confirmation and then perform sql fns
      /*Navigator.push(context,
      MaterialPageRoute(builder: (context)=> PasswordConfirm()));*/
      final _returnedData= await showModalBottomSheet(context: context, builder:(context){
        return PasswordConfirm();  //Temp testing
      });
      _inputPassword=_returnedData;
      print(_inputPassword);  //This is temporary, we will do work with it
      setState(() {
        amountPayable=0;
      });
      
    };
  }

  @override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(outletName==""){
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

  String username,producerID;

  MilkProducerCard(this.username,this.producerID);
  @override
  _MilkProducerCardState createState() => _MilkProducerCardState(this.username,this.producerID);
}

class _MilkProducerCardState extends State<MilkProducerCard> {
  String username="",name="",producerID="",area="",phoneNumber="";
  double amountPayable=0,getMilk=0,givenMilk;
  String _inputPassword;

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
      _inputPassword=_returnedData;
      if(true){ //TODO password validation call as the if condition
        RequestServer server=RequestServer(action: "UPDATE Expenses SET Amount+=$amountPayable where onDate=\"${dates[date]}\"",Qtype: "W");
        var response=await server.getDecodedResponse();
        server.setAction("UPDATE NetAmount SET Expense+=$amountPayable where onDate=\"${dates[date]}\"");
        var response1=await server.getDecodedResponse();
        server.setAction("UPDATE NetAmount SET Profit=Income-Expense where onDate=\"${dates[date]}\"");
        var response2=await server.getDecodedResponse();
        server.setAction("UPDATE MilkProducer SET AmountPayable=0 where ProducerID=\"$producerID\"");
        var response3=await server.getDecodedResponse();
        if(response.toString().compareTo("OK")==0 && response1.toString().compareTo("OK")==0 && response2.toString().compareTo("OK")==0){
          setState(() {
            amountPayable=0;
          });
        }

      }
    };
  }

  String getAmountPayButtonText(){
    if(amountPayable==0){
      return "Amount Paid";
    }
    else{
      return "Pay Producer: $amountPayable";
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
                      //TODO Execute corresponding sql commands + Add in current availability!!!
                      print("Hello");
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
                    color: Colors.blueAccent,
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

