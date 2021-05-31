import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'const.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';



class RequestServer{
  var action;
  var Qtype;
  RequestServer({this.action,this.Qtype});

  var response;
  Future getDecodedResponse() async{
    http.Response response= await http.get(Uri.parse("http://localhost/index.php?action=${action}&Qtype=${Qtype}"));
    if(response.statusCode==200){
      print("Connection to server success! Response code is OK 👍");
      //print("This is the response body: ${response.body}");
      return jsonDecode(response.body);
    }
    else{
      print(response.statusCode);
    }
  }

  Future checkCredentials(String username, String password) async{
    this.action="select * from UserTable where username=\"$username\"";
    this.Qtype="R";
    var response= await getDecodedResponse();

    String passwordHash=getHashedPassword(password);
    // var bytes=utf8.encode(password);
    // var digest=md5.convert(bytes);
    if(response=="Empty"){
      return false;
    }
    if(response[0]["username"]==username && response[0]["password_hash"].toString().toLowerCase().compareTo(passwordHash)==0){
      return true;
    }
    else{
      return false;
    }
  }

  Future checkUserPresence(String username) async{
    this.action="select username from UserTable where username=\"$username\"";
    this.Qtype="R";
    // var response= await getDecodedResponse();
    http.Response response= await http.get(Uri.parse("http://localhost/index.php?action=${action}&Qtype=${Qtype}"));
    if(jsonDecode(response.body)=="Empty"){
      return false;
    }
    else{
      return true;
    }
  }

  void setAction(String inputAction){
    action=inputAction;
    return;
  }
  void setQtype(String inputQtype){
    Qtype=inputQtype;
    return;
  }

}