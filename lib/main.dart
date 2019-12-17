import 'package:flutter/material.dart';
import 'package:team_k_csc_305/menu.dart';
import 'package:team_k_csc_305/orgViewPage/OrgPageNode.dart';
import 'package:team_k_csc_305/orgViewPage/OrgViewPage.dart';
import 'orgViewPage/OrgViewPage.dart';
import 'Clubs-Users-Events/Clubs-Users-Events.dart';
import 'loginPage/loginPage.dart';

//import 'orgViewPage/OrgViewPage.dart';
import 'menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static User appUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetterBoard',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LoginState(),


    );
  }
}

