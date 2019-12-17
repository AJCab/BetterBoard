import 'package:flutter/material.dart';
import 'package:team_k_csc_305/club_configure/add_event.dart';
import 'package:team_k_csc_305/club_configure/club_settings.dart';
import 'package:team_k_csc_305/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_k_csc_305/orgViewPage/orgProfileScreen/orgProfileScreen.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:team_k_csc_305/main.dart';



class GetClubConfig {



  static getClubConfigPage(BuildContext context){

    Firestore.instance.collection('clubs').where('name', isEqualTo: MyApp.appUser.name).getDocuments()
        .then((results) {
        Navigator.pop(context);
        Navigator.push(
        context,
        new MaterialPageRoute(
        builder: (context) => new ClubConfigPage(results.documents[0])));
          });
  }
}
//
class ClubConfigPage extends StatefulWidget {
  DocumentSnapshot document;
  ClubConfigPage(this.document);

  //
  @override ClubConfigState createState() => ClubConfigState(document);
}

//
class ClubConfigState extends State<ClubConfigPage>{

  DocumentSnapshot document;
  ClubConfigState(this.document);

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Club Configuration'),
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  constraints: BoxConstraints.expand(height: 150.0),
                  child: Image.asset('assets/images/URI_Logo.png')
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    MyApp.appUser.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),

                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                        child:
                        Icon(Icons.add,
                          size: 30,
                          color: Colors.grey[500],),
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new AddEventPage()
                        ))
                    ),
                    GestureDetector(
                      child:
                      Icon(Icons.settings,
                        size: 30,
                        color: Colors.grey[500],),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => new ClubSettingsPage()
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                child: Text(
                  document['summary'],
                  softWrap: true,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                      'Upcomming Events: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )
                  )
              ),
              Expanded(
                child:
                StreamBuilder(
                    stream: Firestore.instance.collection('events').where('clubname', isEqualTo: MyApp.appUser.name).orderBy('date').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Text('Retrieving Data...');
                      }
                      return ListView.builder(
                          itemExtent: 200,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) =>
                              OrgEventNode(Event(snapshot.data.documents[index]), snapshot.data.documents[index], true));
                    }

                ),
              )
            ]
        ),

      );


  }
}