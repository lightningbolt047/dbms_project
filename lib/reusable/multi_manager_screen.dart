import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
  var items1;


  Future<dynamic> getFromServer() async{
    if (pageType == pageTypeList.outletManager) {
      RequestServer server = RequestServer(
          action: "select Outlets.outID,Outlet_name,PhoneNumber,TotalIncome,AmountPayable,Area,Available.Milk,Available.Yogurt,Available.Cheese,Available.Butter,Required.Milk as ReqMilk,Required.Yogurt as ReqYogurt,Required.Cheese as ReqCheese,Required.Butter as ReqButter from Outlets,Available,Required where Outlets.outID=Available.outID and Outlets.outID=Required.outID;",
          Qtype: "R");
      items = await server.getDecodedResponse();
      server.setAction("select * from CurrentAvailability where onDate=\"${dates[date]}\"");
      items1=await server.getDecodedResponse();
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
  double getProgressBarPercent(double value){
    double maxValue=5000;
    if(value/maxValue>1){
      return 1;
    }
    else{
      return value/maxValue;
    }
  }

  void updateStateFromChild() async{
    if(pageType==pageTypeList.outletManager){
      setState(() {
        populated=false;
      });
      await getFromServer();
    }
  }


  List<Widget> getCards() {
    double availMilk,availButter,availCheese,availYogurt;
    availMilk=availButter=availCheese=availYogurt=0;
    List<Widget> _cards = [];
    //_cards.clear();
    if (pageType == pageTypeList.outletManager) {
      availMilk=double.parse(items1[0]["Milk"]);
      availButter=double.parse(items1[0]["Butter"]);
      availCheese=double.parse(items1[0]["Cheese"]);
      availYogurt=double.parse(items1[0]["Yogurt"]);
      _cards.add(Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Availability",style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80,
                          animation: true,
                          animationDuration: 2000,
                          lineWidth: 5,
                          percent: getProgressBarPercent(availMilk),
                          center: Text("$availMilk"),
                          progressColor: Colors.blueAccent,
                        ),
                        Text("Milk")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80,
                          animation: true,
                          animationDuration: 2000,
                          lineWidth: 5,
                          percent: getProgressBarPercent(availButter),
                          center: Text("$availButter"),
                          progressColor: Colors.yellow,
                        ),
                        Text("Butter")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80,
                          animation: true,
                          animationDuration: 2000,
                          lineWidth: 5,
                          percent: getProgressBarPercent(availCheese),
                          center: Text("$availCheese"),
                          progressColor: Colors.lightGreenAccent,
                        ),
                        Text("Cheese")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80,
                          animation: true,
                          animationDuration: 2000,
                          lineWidth: 5,
                          percent: getProgressBarPercent(availYogurt),
                          center: Text("$availYogurt"),
                          progressColor: Colors.blueGrey,
                        ),
                        Text("Yogurt")
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ));
      for (int i = 0; i < items.length; i++) {
        _cards.add(OutletCard(username, items[i]["outID"],updateStateFromChild));
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
