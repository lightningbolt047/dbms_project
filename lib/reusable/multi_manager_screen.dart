import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'const.dart';
import 'cards.dart';
import 'add_new_details.dart';
import 'request_server.dart';


class MultiManagerScreen extends StatefulWidget {
  final pageType;
  final String username;
  MultiManagerScreen(this.pageType, this.username);
  @override
  _MultiManagerScreenState createState() => _MultiManagerScreenState(pageType,username);
}

class _MultiManagerScreenState extends State<MultiManagerScreen> {
  final pageType;
  final String username;

  _MultiManagerScreenState(this.pageType,this.username);

  String getAppBarText(){
    if(pageType==pageTypeList.outletManager){
      return "Outlet Details";
    }
    else if(pageType==pageTypeList.procurementManager){
      return "Milk Producers";
    }
    else if(pageType==pageTypeList.transportManager){
      return "Transport";
    }
    return "No text available";
  }

  bool populated=false;
  var items;


  Future<dynamic> getFromServer() async{
    if (pageType == pageTypeList.outletManager) {
      RequestServer server = RequestServer(
          action: "select Outlets.outID,Outlet_name,PhoneNumber,TotalIncome,AmountPayable,Area,Available.Milk,Available.Yogurt,Available.Cheese,Available.Butter,Required.Milk as ReqMilk,Required.Yogurt as ReqYogurt,Required.Cheese as ReqCheese,Required.Butter as ReqButter from Outlets,Available,Required where Outlets.outID=Available.outID and Outlets.outID=Required.outID;",
          Qtype: "R");
      items = await server.getDecodedResponse();
    }
    else if (pageType == pageTypeList.procurementManager) {
      RequestServer server = RequestServer(
          action: "select ProducerID from MilkProducer", Qtype: "R");
      items = await server.getDecodedResponse();
    }
    else if (pageType == pageTypeList.transportManager) {
      RequestServer server = RequestServer(
          action: "select TruckID from Transport", Qtype: "R");
      items = await server.getDecodedResponse();
    }
    setState(() {
      populated=true;
    });
  }

  List<Widget> getCards() {
    List<Widget> _cards = [];
    //_cards.clear();
    if (pageType == pageTypeList.outletManager) {
      for (int i = 0; i < items.length; i++) {
        _cards.add(OutletCard(username, items[i]["outID"]));
      }
    }
    else if (pageType == pageTypeList.procurementManager) {
      for (int i = 0; i < items.length; i++) {
        _cards.add(MilkProducerCard(username, items[i]["ProducerID"]));
      }
    }
    else if (pageType == pageTypeList.transportManager) {
      for (int i = 0; i < items.length; i++) {
        _cards.add(Transport(items[i]["TruckID"]));
      }
    }
    return _cards;
  }

  Function getFloatingActionButtonAction(){
    if(pageType==pageTypeList.outletManager){
      return () async{
        await showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.outletManager);  //Temp testing
        });
        setState(() {
          populated=false;
        });
        await getFromServer();
      };
    }
    if(pageType==pageTypeList.procurementManager){
      return () async{
        await showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.procurementManager);  //Temp testing
        });
        setState(() {
          populated=false;
        });
        await getFromServer();
      };
    }
    if(pageType==pageTypeList.transportManager){
      return () async{
        await showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.transportManager);  //Temp testing
        });
        setState(() {
          populated=false;
        });
        await getFromServer();
      };
    }
    return (){};
  }


  @override
  void initState() {
    getFromServer();
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
        appBar: AppBar(
          title: Text(
            getAppBarText()
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(FontAwesomeIcons.powerOff,color: Colors.white,),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
          elevation: 3,
          onPressed: getFloatingActionButtonAction(),
        ),
        body: ListView(
                children: getCards(),
              ),
      ),
    );
  }
}
