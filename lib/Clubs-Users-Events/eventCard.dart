import 'package:flutter/material.dart';
import 'event.dart';
import 'eventDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_k_csc_305/orgViewPage/OrgPageNode.dart';

class eventCard extends StatefulWidget {
  DocumentSnapshot evnt;

  eventCard(this.evnt);

  @override
  EventCardState createState() {
    return EventCardState(evnt);
  }
}

class EventCardState extends State<eventCard> {
  DocumentSnapshot document;
  Event evnt;

  EventCardState(this.document) {
    evnt = Event(
        document['clubname'],
        document['eventname'],
        document['summary'],
        document['time'],
        document['locations'],
        document['date']);
  }

  void initState() {
    super.initState();
  }

  Widget get eventCard {
    return new Center(
      child: new Container(
        width: 400.0,
        height: 150.0,
        child: new Card(
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
              //bottom: 2.0,
              left: 2.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.event),
                    title: new Text(document['clubname'] + ' - ' +document['date']),
                    subtitle: new Text(document['eventname'])),
                ButtonTheme.bar(
                    child: ButtonBar(children: <Widget>[
//                      FlatButton(
//                        child: const Text('View Club'),
//                        onPressed: () { OrgPageNode.(MyApp.appUser.username, context)},
//                      ),
                      RaisedButton(
                        child: const Text('About'),
                        onPressed: () => showEventDetailPage(document, context),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new InkWell(
      //onTap: () => showEventDetailPage(),
      child: new Container(
        //height: 115.0,
        child: new Stack(
          children: <Widget>[eventCard],
        ),
      ),
    );
  }

  static showEventDetailPage(DocumentSnapshot document, BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new EventDetailPage(document);
    }));
  }
}