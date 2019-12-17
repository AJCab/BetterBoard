import 'package:flutter/material.dart';
import 'event.dart';
import 'eventCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailPage extends StatefulWidget {
  DocumentSnapshot document;

  EventDetailPage(this.document);

  @override
  _EventDetailPageState createState() => new _EventDetailPageState(document);
}

class _EventDetailPageState extends State<EventDetailPage> {

  DocumentSnapshot document;

  _EventDetailPageState(this.document);

  Widget get eventProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            document['clubname'],
            style: new TextStyle(fontSize: 32.0),
          ),
          SizedBox(height: 20),
          new Text(
            document['eventname'],
            style: new TextStyle(fontSize: 20.0),
          ),
          new Text(
            document['date'],
            style: new TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          new Text(
            "Location: " + document['location'],
            style: new TextStyle(fontSize: 15.0),
          ),
          SizedBox(height: 10),
          Text(document['summary'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(document['eventname'])//new Text('Meet ${widget.event.name}'),
      ),
      body: new ListView(
        children: <Widget>[eventProfile],
      ),
    );
  }
}