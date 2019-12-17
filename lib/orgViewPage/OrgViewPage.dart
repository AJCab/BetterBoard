import 'package:flutter/material.dart';
import 'OrgPageNode.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:team_k_csc_305/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(OrgViewPage());


//Unused at the moment
class OrgViewPage extends StatelessWidget {



  @override Widget build(BuildContext context) {




    return MaterialApp(
      title: 'OrgViewPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrgViewWidget(title: 'Org View'),
    );
  }
}



class OrgViewWidget extends StatefulWidget{
  OrgViewWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override OrgViewState createState() => OrgViewState();
}





class OrgViewState extends State<OrgViewWidget>{

  List<Widget> orgNodes;
  static int numNodes = 0;

  OrgViewState(){
    orgNodes = new List<Widget>();
  }

  //Add temp clubs to clubs list if there are none


  List<Widget> getNodes(List<Club> clubs){
    Color color;


    orgNodes.add(Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: ClipPath(
            clipper: ClippingClass(),
            child: Container(
              height: 130.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.lightBlue[900],
                    Colors.blue
                  ])),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/Notification.png"),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
            ),
          ),
        )
      ],
    )
    );


    for(int i = 0; i < Club.allClubs.length; i++){
      if(i%2 == 0) color = Colors.grey;
      else color = Colors.white30;
      orgNodes.add(OrgPageNode(Club.allClubs[i], color));
      numNodes++;
    }



    return orgNodes;
  }

  @override Widget build(BuildContext context) {
    //Adds temporary clubs to the clubs list in the Club class.
    return Scaffold(
      drawer: Menu(),
      appBar: new AppBar(
        title: new Text("Browse Clubs"),
      ),
      body:
        StreamBuilder(
          stream: Firestore.instance.collection('clubs').orderBy('name').snapshots(),
          builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('loading...');
              }
              return ListView.builder(

                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    OrgPageNode(Club(snapshot.data.documents[index]),Colors.white),
              );
            }
          ),
        );
    }
}



