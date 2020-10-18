import 'package:dairymanagement/reusable/request_items.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'const.dart';
import 'package:flutter/material.dart';

class OutletUniqueScreen extends StatefulWidget {
  @override
  _OutletUniqueScreenState createState() => _OutletUniqueScreenState();
}

class _OutletUniqueScreenState extends State<OutletUniqueScreen> {
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
                  Text("121000",
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
                      child: Text("Pay Outstanding Amount to Company: 20000",
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
              child: Text("Currently Available in Store: ChennaiOut, Area",
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
                    child: Text("Milk: 25",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Butter: 25",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Cheese: 25",style:TextStyle(color: Colors.blueGrey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,1),
                    child: Text("Yogurt: 25",style:TextStyle(color: Colors.blueGrey)),
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
                        child: Text("Milk: 20",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
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
                        child: Text("Milk: 20",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
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
                        child: Text("Milk: 20",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
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
                        child: Text("Milk: 20",style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                        ),),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2,0,5,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.plus,color: Colors.white,), action:(){
                            return;
                          })
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5,0,10,5),
                          child: RoundActionButton(child: Icon(FontAwesomeIcons.minus,color: Colors.white,), action:(){
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
                            //TODO sql queries to sell items
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
