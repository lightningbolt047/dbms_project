import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'const.dart';
import 'dart:convert';


class RequestServer{
  final action;
  final Qtype;
  RequestServer({@required this.action,@required this.Qtype});

  var response;
  Future getDecodedResponse() async{
    var map = Map<String,dynamic>();
    map['action']="select * from teaches";
    map['Qtype']="R";
    http.Response response= await http.get("http://localhost/index.php?action=${action}&Qtype=${Qtype}");
    if(response.statusCode==200){
      print("Connection to server success!");
      //print("This is the json output: ${response.body}");
      return jsonDecode(response.body);
    }
    else{
      print(response.statusCode);
    }
  }

}