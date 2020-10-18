import 'package:dairymanagement/reusable/request_items.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'request_server.dart';
import 'const.dart';
import 'package:flutter/material.dart';

class OutletUniqueScreen extends StatefulWidget {
  String outletID;
  OutletUniqueScreen(this.outletID);
  @override
  _OutletUniqueScreenState createState() => _OutletUniqueScreenState(this.outletID);
}

class _OutletUniqueScreenState extends State<OutletUniqueScreen> {

  double _singleSessionIncome=0,totalIncome=0,amountPayable=0;
  String outletID="",outletName="",phoneNumber="",area="";
  double availMilk=0,availButter=0,availCheese=0,availYogurt=0;

  double saleMilk=0,saleButter=0,saleCheese=0,saleYogurt=0;

  _OutletUniqueScreenState(this.outletID);

  Future<bool> populateData() async{
    RequestServer server = RequestServer(action: "select * from Outlets,Available where Outlets.outID=Available.outID and Outlets.outID=$outletID;", Qtype: "R");
    var items= await server.getDecodedResponse();
    setState(() {
      outletName=items[0]["Outlet_name"];
      phoneNumber=items[0]["PhoneNumber"];
      area=items[0]["Area"];
      amountPayable=double.parse(items[0]["AmountPayable"]);
      availButter=double.parse(items[0]["Butter"]);
      availCheese=double.parse(items[0]["Cheese"]);
      availMilk=double.parse(items[0]["Milk"]);
      availYogurt=double.parse(items[0]["Yogurt"]);
      totalIncome=double.parse(items[0]["TotalIncome"]);
    });
    return true;
  }


  @override
  void initState() {
    // TODO: implement initState
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(FontAwesomeIcons.plus,color: Colors.white,),
          elevation: 3,
          onPressed: (){
            showModalBottomSheet(context: context, builder:(context){
              return RequestItemsSheet("012");  //Temp testing outletID is the argument here
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text("$_singleSessionIncome",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  ),
                  ),
                  Text("Worth of items sold this session", style: TextStyle(color: Colors.blueGrey),),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25,0,10,5),
                    child: FlatButton(
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text("Pay Outstanding Amount to Company: $amountPayable",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: (){
                        //TODO sql queries to pay the company items
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
              child: Text("Currently Available in Store: $outletName, $area",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey
              ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14,2,20,10),
              child: Divider(
                color: Colors.blueGrey,
                endIndent: 750,
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,0,20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Milk: $availMilk",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Butter: $availButter",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Cheese: $availCheese",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Yogurt: $availYogurt",style:TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
              child: Text("Sales",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14,2,20,10),
              child: Divider(
                color: Colors.blueAccent,
                endIndent: 950,
                thickness: 2,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Milk: $saleMilk",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleMilk<availMilk){
                                saleMilk++;
                              }
                            });
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleMilk>0){
                                saleMilk--;
                              }
                            });
                            return;
                          })
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Butter: $saleButter",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleButter<availButter){
                                saleButter++;
                              }
                            });
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleButter>0){
                                saleButter--;
                              }
                            });
                            return;
                          })
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Cheese: $saleCheese",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleCheese<availCheese){
                                saleCheese++;
                              }
                            });
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleCheese>0){
                                saleCheese--;
                              }
                            });
                            return;
                          })
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Yogurt: $saleYogurt",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleYogurt<availYogurt){
                                saleYogurt++;
                              }
                            });
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
                            setState(() {
                              if(saleYogurt>0){
                                saleYogurt--;
                              }
                            });
                            return;
                          })
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25,0,10,5),
                        child: FlatButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text("Sell items",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: (){
                            //TODO sql queries to sell items, set saleValues to 0 and add the amount to amountPayable and _singleSessionIncome
                            setState(() {
                              amountPayable+=saleMilk*milkRate;
                              amountPayable+=saleButter*butterRate;
                              amountPayable+=saleCheese*cheeseRate;
                              amountPayable+=saleYogurt*yogurtRate;

                              availMilk-=saleMilk;
                              availButter-=saleButter;
                              availCheese-=saleCheese;
                              availYogurt-=saleYogurt;

                              _singleSessionIncome+=(saleMilk*milkRate)+(saleButter*butterRate)+(saleCheese*cheeseRate)+(saleYogurt*yogurtRate);

                              saleMilk=saleButter=saleCheese=saleYogurt=0;
                            });
                          },
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
