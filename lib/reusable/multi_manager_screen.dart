import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'const.dart';
import 'cards.dart';
import 'add_new_details.dart';


class MultiManagerScreen extends StatefulWidget {
  final pageType;
  MultiManagerScreen(this.pageType);
  @override
  _MultiManagerScreenState createState() => _MultiManagerScreenState(pageType);
}

class _MultiManagerScreenState extends State<MultiManagerScreen> {
  final pageType;

  _MultiManagerScreenState(this.pageType);

  String getAppBarText(){
    if(pageType==pageTypeList.outletManager){
      return "Outlet Details";
    }
    else if(pageType==pageTypeList.procurementManager){
      return "Milk Producers";
    }
    return "No text available";
  }

  Future<List> getCards() async{
    List<Widget> _cards=[];
    if(pageType==pageTypeList.outletManager){
      //TODO add page specific sql query here
      _cards.add(outletCard("Very cool name", 10000, "2823782", 6, 0, 0, 0, 4000,"42069"),);
      _cards.add(outletCard("Not so cool name", 5000, "582378237", 6, 0, 0, 0, 3000,"96"),);
      _cards.add(outletCard("Worst name ever", 5000, "2823", 6, 0, 0, 0, 4000,"0192"),);
    }
    else if(pageType==pageTypeList.procurementManager){
      _cards.add(MilkProducerCard("Prodname","12033","Area","29329839",35000,1000));
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
        print("Not yet defined");
      };
    }
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
