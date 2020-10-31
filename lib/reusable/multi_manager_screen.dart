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

  Future<List<Widget>> getCards() async {
    List<Widget> _cards = [];
    if (pageType == pageTypeList.outletManager) {
      RequestServer server = RequestServer(
          action: "select Outlets.outID,Outlet_name,PhoneNumber,TotalIncome,AmountPayable,Area,Available.Milk,Available.Yogurt,Available.Cheese,Available.Butter,Required.Milk as ReqMilk,Required.Yogurt as ReqYogurt,Required.Cheese as ReqCheese,Required.Butter as ReqButter from Outlets,Available,Required where Outlets.outID=Available.outID and Outlets.outID=Required.outID;",
          Qtype: "R");
      var items = await server.getDecodedResponse();
      for (int i = 0; i < items.length; i++) {
        print(items[i]["outID"]);
        _cards.add(OutletCard(username, items[i]["outID"]));
      }
    }
    else if (pageType == pageTypeList.procurementManager) {
      RequestServer server = RequestServer(
          action: "select ProducerID from MilkProducer", Qtype: "R");
      var items = await server.getDecodedResponse();
      for (int i = 0; i < items.length; i++) {
        _cards.add(MilkProducerCard(username, items[i]["ProducerID"]));
      }
    }
    else if (pageType == pageTypeList.transportManager) {
      RequestServer server = RequestServer(
          action: "select TruckID from Transport", Qtype: "R");
      var items = await server.getDecodedResponse();
      for (int i = 0; i < items.length; i++) {
        _cards.add(Transport(items[i]["TruckID"]));
      }
    }
    return _cards;
  }

  Function getFloatingActionButtonAction(){
    if(pageType==pageTypeList.outletManager){
      return (){
        showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.outletManager);  //Temp testing
        });
      };
    }
    if(pageType==pageTypeList.procurementManager){
      return (){
        showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.procurementManager);  //Temp testing
        });
      };
    }
    if(pageType==pageTypeList.transportManager){
      return (){
        showModalBottomSheet(context: context, builder:(context){
          return AddDetails(pageTypeList.transportManager);  //Temp testing
        });
      };
    }
    return (){};
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            getAppBarText()
          ),
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
        body: FutureBuilder(
          future: getCards(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(child: CircularProgressIndicator());
            }
            else{
              return ListView(
                children: snapshot.data,
              );
            }
          },
        ),
      ),
    );
  }
}
