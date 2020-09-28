import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'const.dart';
import 'package:flutter/material.dart';

class EmployeeUniqueScreen extends StatefulWidget {
  @override
  _EmployeeUniqueScreenState createState() => _EmployeeUniqueScreenState();
}

class _EmployeeUniqueScreenState extends State<EmployeeUniqueScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child:SizedBox(
                height: 60,
              ),
            ),
            Expanded(
              child: Text(
                "Employee Details",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 40
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                ),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                              Text("FirstName LastName",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("01101",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("9837472224",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_sharp,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("20 Jul 2017",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("20000",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("Milk2Butter",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 40,
                                ),
                                sizedBoxSmallInRow,
                                Text("20th House, Nth Street, Area 51, Country0",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,20,40,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  color: Colors.blueAccent,
                                  textColor: Colors.white,
                                  child: Text("Credit salary: 20000",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  ),
                                  onPressed: null ,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
