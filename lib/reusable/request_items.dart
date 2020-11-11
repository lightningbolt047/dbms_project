import 'package:dairymanagement/reusable/const.dart';
import 'package:dairymanagement/reusable/request_server.dart';
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
  bool _errorTextVisible=false;
  Color _errorTextColor=Colors.green;
  String _errorText="";

  double _reqMilk=0,_reqButter=0,_reqCheese=0,_reqYogurt=0;
  bool populated=false;


  Future<bool> populateData() async {
    RequestServer server = RequestServer(
        action: "SELECT * from Required  where outID=\"$outletID\"",
        Qtype: "R");
    var items = await server.getDecodedResponse();
    setState(() {
      _reqMilk = double.parse(items[0]['Milk']);
      _reqButter = double.parse(items[0]['Butter']);
      _reqCheese = double.parse(items[0]['Cheese']);
      _reqYogurt = double.parse(items[0]['Yogurt']);
      populated = true;
    });
  }

   void initState(){
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
                    RoundActionButton(child: Icon(FontAwesomeIcons.check,color:Colors.white),action: () async{
                      RequestServer server=RequestServer(action:"UPDATE Required SET Milk=$_reqMilk,Yogurt=$_reqYogurt,Cheese=$_reqCheese,Butter=$_reqButter where outID=\"$outletID\"",Qtype: "W");
                      var response=await server.getDecodedResponse();
                      if(response.toString().compareTo("OK")!=0){
                        setState(() {
                          _errorTextVisible=true;
                          _errorText="Something went wrong";
                          _errorTextColor=Colors.red;
                        });
                        return;
                      }
                      setState(() {
                        _errorTextVisible=true;
                        _errorText="Order placed successfully";
                        _errorTextColor=Colors.green;
                      });
                      Navigator.pop(context);
                    },),
        ]
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 2),
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
                  padding: const EdgeInsets.fromLTRB(40, 3, 40, 2),
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
                  padding: const EdgeInsets.fromLTRB(40, 3, 40, 2),
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
                  padding: const EdgeInsets.fromLTRB(40, 3, 40, 2),
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
                Visibility(
                  child: Text(_errorText,style: TextStyle(
                      color: _errorTextColor
                  ),),
                  visible: _errorTextVisible,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

