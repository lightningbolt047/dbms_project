import 'package:dairymanagement/reusable/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'const.dart';

class RequestItemsSheet extends StatefulWidget {
  String outletID;
  RequestItemsSheet(this.outletID);
  @override
  _RequestItemsSheetState createState() => _RequestItemsSheetState(this.outletID);
}

class _RequestItemsSheetState extends State<RequestItemsSheet> {
  String outletID="";

  _RequestItemsSheetState(this.outletID);

  double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF727272),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child:Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Request New Stock", style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),),
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color:Colors.white),action: (){
                      setState(() {
                        //TODO Execute SQL query to modify values for the outlet (Place request for new stocks) and close the activity
                        Navigator.pop(context);
                        return;
                      });
                    },),
        ]
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Milk amount: $_reqMilk",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      sizedBoxSmallInRow,
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqMilk<=5000){
                              _reqMilk+=10;
                            }
                          });
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqMilk>0){
                              _reqMilk-=10;
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Butter amount: $_reqButter",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      sizedBoxSmallInRow,
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqButter<=5000){
                              _reqButter+=10;
                            }
                          });
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqButter>0){
                              _reqButter-=10;
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Yogurt amount: $_reqYogurt",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      sizedBoxSmallInRow,
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqYogurt<=5000){
                              _reqYogurt+=10;
                            }
                          });
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqYogurt>0){
                              _reqYogurt-=10;
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cheese amount: $_reqCheese",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      sizedBoxSmallInRow,
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqCheese<=5000){
                              _reqCheese+=10;
                            }
                          });
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,),action: (){
                          setState(() {
                            if(_reqCheese>0){
                              _reqCheese-=10;
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

