// Flutter code sample for

// This sample shows creation of a [Card] widget that shows album information
// and two actions.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/eventCard.dart';
import 'package:team_k_csc_305/frontPage/FrntPgNode.dart';
import 'package:team_k_csc_305/menu.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/event.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/eventCard.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/eventDetail.dart';

void main() => runApp(FrntViewPage());

/// This Widget is the main application widget.
class FrntViewPage extends StatelessWidget {
  static const String _title = 'Front Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrntPgWidget(title: _title),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class FrntPgWidget extends StatefulWidget {
  FrntPgWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FrntViewState createState() => _FrntViewState();
}

class _FrntViewState extends State<FrntPgWidget> {

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: Text('Featured'),
      ),
      drawer: Menu(),
      body: new Container(
        child: new Center(
          child: new EventList(),
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {

  EventList();


  @override
  Widget build(BuildContext context) {
    //return _buildList(context);
    return StreamBuilder(
        stream: Firestore.instance.collection('events').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('loading...');
          }
          return ListView.builder(

            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                eventCard(snapshot.data.documents[index]),
          );
        }
    );
  }
}
