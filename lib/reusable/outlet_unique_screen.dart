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
  bool populated=false;

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
      populated=true;
    });
    return true;
  }


  @override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(populated==false){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.lightBlue,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: Icon(FontAwesomeIcons.plus,color: Colors.white,),
            elevation: 3,
            onPressed: (){
              showModalBottomSheet(context: context, builder:(context){
                return RequestItemsSheet("012");  //Temp testing outletID is the argument here
              });
            },
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child:SizedBox(
                  height: 10,
                ),
              ),
              Expanded(
                  child: Column(
                    children: [
                      Text(
                        "$outletName, $area",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40
                        ),
                      ),
                      sizedBoxInColumn,
                      Text(
                        "Currently Available",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),
                      ),
                      sizedBoxInColumn,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Milk: $availMilk",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),),
                          sizedBoxSmallInRow,
                          Text("Butter: $availButter",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),),
                          sizedBoxSmallInRow,
                          Text("Cheese: $availCheese",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),),
                          sizedBoxSmallInRow,
                          Text("Yogurt: $availYogurt",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),)
                        ],
                      )
                    ],
                  )
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  ),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Income this session: $_singleSessionIncome",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.w700
                          ),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Milk: $saleMilk",style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 20
                                          ),),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(2,0,5,5),
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),color:Colors.lightBlue, action:(){
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
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Butter: $saleButter",style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 20
                                          ),),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(2,0,5,5),
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40,20,40,20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Cheese: $saleCheese",style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 20
                                          ),),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(2,0,5,5),
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0,1,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Yogurt: $saleYogurt",style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 20
                                          ),),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(2,0,5,5),
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                            child: CustomRoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),color: Colors.lightBlue, action:(){
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40,20,40,10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                    child: FlatButton(
                                      color: Colors.lightBlue,
                                      textColor: Colors.white,
                                      child: Text("Checkout",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: () async{
                                        double oldAmountPayable=amountPayable;
                                        amountPayable+=saleMilk*saleMilkRate;
                                        amountPayable+=saleButter*saleButterRate;
                                        amountPayable+=saleCheese*saleCheeseRate;
                                        amountPayable+=saleYogurt*saleYogurtRate;
                                        availMilk-=saleMilk;
                                        availButter-=saleButter;
                                        availCheese-=saleCheese;
                                        availYogurt-=saleYogurt;
                                        RequestServer server=RequestServer(action: "UPDATE Available SET Milk=$availMilk,Yogurt=$availYogurt,Cheese=$availCheese,Butter=$availButter where outID=\"$outletID\"",Qtype: "W");
                                        var response=await server.getDecodedResponse();
                                        server.setAction("UPDATE Outlets SET AmountPayable=$amountPayable,TotalIncome+=${amountPayable-oldAmountPayable} where outID=\"$outletID\"");
                                        var response1=await server.getDecodedResponse();
                                        if(response.toString().compareTo("OK")!=0 || response1.toString().compareTo("OK")!=0){
                                          print("An error occurred: Response0: "+response.toString()+" Response1: "+response1.toString());
                                          return;
                                        }
                                        setState(() {
                                          _singleSessionIncome+=(saleMilk*saleMilkRate)+(saleButter*saleButterRate)+(saleCheese*saleCheeseRate)+(saleYogurt*saleYogurtRate);
                                          saleMilk=saleButter=saleCheese=saleYogurt=0;
                                          populated=false;
                                        });
                                        await populateData();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                    child: FlatButton(
                                      color: Colors.lightBlue,
                                      textColor: Colors.white,
                                      child: Text("Pay Outstanding Amount to Company: $amountPayable",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: (){
                                        //TODO sql queries to pay the company money
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                    child: FlatButton(
                                      color: Colors.lightBlue,
                                      textColor: Colors.white,
                                      child: Text("Logout",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
