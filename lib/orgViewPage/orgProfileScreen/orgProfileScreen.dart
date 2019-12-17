import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/eventCard.dart';


class OrgProfileWidget extends StatefulWidget{
  //OrgProfileWidget({Key key, this.title}) : super(key: key);

  Club orgProfile;
  bool interested;

  OrgProfileWidget(Club profile, bool interested){
    this.orgProfile = profile;
    this.interested = interested;

  }



  @override
  _OrgProfileState createState() => _OrgProfileState(orgProfile, interested);
}


class _OrgProfileState extends State<OrgProfileWidget>{

  Club orgProfile;
  bool isInterested;

  _OrgProfileState(Club orgProfile, bool interested){
    this.orgProfile = orgProfile;
    isInterested = interested;
  }




  @override Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(orgProfile.name),
        ),

        body:Container(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              //Picture Container
                Container(

                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.black),
                      )
                  ),
                  constraints: BoxConstraints.expand(height: 100),
                  child:
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:
                  Image.asset(
                      orgProfile.image,

                      fit: BoxFit.contain
                  )
                ),
                ),
//Club Name in large text
                Container(
                  constraints: BoxConstraints.expand(height: 75),
                  alignment: Alignment.center,
                  child: Text(
                      orgProfile.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                  ),
                ),
//Interested button
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Interested: "),
                      Switch(
                          value: isInterested,
                          activeColor: Colors.blue,
                          onChanged: (bool value) {

                            if(value == false){
                                Firestore.instance.collection('interested').where('username', isEqualTo: MyApp.appUser.username).where('clubname', isEqualTo: orgProfile.name).getDocuments().then((value)
                                {
                                  value.documents.forEach((f){
                                    f.reference.delete();
                                    });
                                });
                            }else{
                              Map<String, String> newEntry = new Map<String, String>();
                              newEntry['username'] = MyApp.appUser.username;
                              newEntry['clubname'] = orgProfile.name;
                              Firestore.instance.collection('interested').document().setData(newEntry);
                                print('Adding');
                              }

                            setState(() {
                              isInterested = value;
                           });
                          },

                      ),
                    ]
                  ),


                ),
//Club summary
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child:
                      Text(
                      'Summary:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      )
                  )
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(15,0,0,0),
                    child:
                      Text(orgProfile.summary),
                  ),
//Club events
                Container(
                    constraints: BoxConstraints.expand(height: 50),
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding:  EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child:
                        Text(
                          'Upcoming Events:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        )
                    )
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  constraints: BoxConstraints(
                    minHeight: 2,
                  ),
                ),
                Expanded(
                  child:
                StreamBuilder(
                  stream: Firestore.instance.collection('events').where('clubname', isEqualTo: orgProfile.name).orderBy('date').snapshots(),
                  builder: (context, snapshot) {
                      if(!snapshot.hasData){
                          return Text('Retrieving Data...');
                        }
                      return ListView.builder(
                      itemExtent: 200,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) =>
                          OrgEventNode(Event(snapshot.data.documents[index]), snapshot.data.documents[index], false));
                  }

                  ),
                )
              ]
            )
        )


    );




  }

}

class OrgEventWidget extends StatefulWidget{

  final Event orgEvent;

  OrgEventWidget(this.orgEvent);



  @override
  OrgEventState createState() => OrgEventState(orgEvent);

}

class OrgEventState extends State<OrgEventWidget>{

  final Event orgEvent;

  OrgEventState(this.orgEvent);

  @override Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}


class OrgEventNode extends StatelessWidget {

  final Event orgEvent;
  final DocumentSnapshot document;
  bool editMode;
  OrgEventNode(this.orgEvent, this.document, this.editMode);


  void deleteEvent(){
      Firestore.instance.collection('events').document(document.documentID).delete();
  }

  @override Widget build(BuildContext context) {
    // TODO: implement build


    if(editMode){
      return Center(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.event),
                      title: new Text(orgEvent.clubname),
                      subtitle: new Text(orgEvent.name)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: const Text('About'),
                        onPressed: () =>
                            EventCardState.showEventDetailPage(
                                document, context),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      RaisedButton(
                        child: const Text('Delete'),
                        onPressed: () => deleteEvent()
                            ,
                        color: Colors.red,
                        textColor: Colors.white,
                      ),

                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      );

    }else {
      return Center(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.event),
                      title: new Text(orgEvent.clubname),
                      subtitle: new Text(orgEvent.name)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: const Text('About'),
                        onPressed: () =>
                            EventCardState.showEventDetailPage(
                                document, context),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),

                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      );
    }
//    return GestureDetector(
//      child:
//
//        Container(
//
//          decoration: BoxDecoration(
//            color: Colors.grey,
//            border: Border(
//              top: BorderSide(width: 1.0, color: Colors.black),
//              bottom: BorderSide(width: 1.0, color: Colors.black),
//              ),
//          ),
//
//          child:
//
//            Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
//                  child:
//                    Text(orgEvent.name + ' - ' + orgEvent.date,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20,
//                      ),
//
//                    )
//                ),
//      Expanded(
//          child:
//                Container(
//                    padding: EdgeInsets.all(10),
//                    height: 300,
//                    child:
//                        Text(
//                          orgEvent.summary,
//                          textAlign: TextAlign.center,
//                          maxLines: 100,
//                          softWrap: true,
//                          overflow: TextOverflow.ellipsis,
//
//                        )
//                ),
//      ),
//                Container(
//                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      //Text('Time: ' + orgEvent.time),
//                      //Text('Location : ' + orgEvent.location)
//                      ],
//                    ),
//                ),
//        ]),
//
//    ),
//
//      onTap: () => null,
//    );
  }


}