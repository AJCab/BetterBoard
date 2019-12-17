import 'package:flutter/material.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:team_k_csc_305/orgViewPage/orgProfileScreen/orgProfileScreen.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/*
Banner node for Org View Page
 */

class OrgPageNode extends StatelessWidget{

    final Club orgProfile;
    final Color color;

    OrgPageNode(this.orgProfile, this.color);

    @override
    Widget build(BuildContext context) {

    return GestureDetector(

      child:
        Container(
      constraints: BoxConstraints.expand(height: 100.0),
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 2.0, color: Colors.black),
          bottom: BorderSide(width: 2.0, color: Colors.black),
          left: BorderSide(width: 2.0, color: Colors.black),
          right: BorderSide(width: 2.0, color: Colors.black),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
     margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,


        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/URI_Logo.png',
                fit: BoxFit.fitHeight,
                )
          ),
          Text(orgProfile.name),
          RaisedButton(
            child: const Text('About'),
            onPressed: () => isUserInterested(MyApp.appUser.username, context),
            color: Colors.blue,
            textColor: Colors.white,
          )
        ],

      )
    ),
          onTap:()=> null


    );
  }

    isUserInterested(String username, BuildContext context){
          Firestore.instance
              .collection('interested')
              .where('username', isEqualTo: username).where('clubname', isEqualTo: orgProfile.name)
              .getDocuments()
              .then((result){
                  List<DocumentSnapshot> documents = result.documents;
                  if(documents.length > 0){
                    print(documents.length);

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => new OrgProfileWidget(orgProfile, true)
                              )
                          );
                  }else{
                    print(documents.length);

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new OrgProfileWidget(orgProfile, false)
                        )
                    );
                  }
          }

          );

    }



}
