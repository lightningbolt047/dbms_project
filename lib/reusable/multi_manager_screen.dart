import 'package:flutter/material.dart';
import 'const.dart';
import 'cards.dart';


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
      return _cards;
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
