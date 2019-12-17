import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_k_csc_305/main.dart';

//
class ClubSettingsPage extends StatefulWidget {
  ClubSettingsPage();

  //
  @override ClubSettingsState createState() => ClubSettingsState();
}

//
class ClubSettingsState extends State<ClubSettingsPage> {
  ClubSettingsState();
  //Variables
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  String documentid;


  void changeClubSettings(){
    Map<String, String> updatedInfo = new Map<String, String>();

    updatedInfo['summary'] = description.text;
    Firestore.instance.collection('clubs').where('name', isEqualTo: MyApp.appUser.name).getDocuments()
    .then((result){
       Firestore.instance.collection('clubs').document(result.documents[0].documentID).updateData(updatedInfo);

    });

  }

  @override Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Club Settings')
        ),
        body: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                //NAME OF CLUB or ORGANIZATION//

                //SizedBox(height:10),
                Container(
                    padding: const EdgeInsets.all(0),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                        SizedBox(width: 310,
//                            child:
////                            TextField(
////                              obscureText: false,
////                              decoration: InputDecoration(
////                                border: OutlineInputBorder(),
////                                labelText: 'Name of Club/Organization',
////                              ),
////                              controller: name,
////                            )
//                        )
                      ],
                    )
                ),

                //DESCRIPTION OF CLUB//

                Container(
                    padding: const EdgeInsets.all(32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description',
                              ),
                              controller: description,
                            )
                        )
                      ],
                    )
                ),

                //SAVE//

                SizedBox(height:10),
                ButtonTheme(
                    minWidth: 200,
                    child: MaterialButton(
                      onPressed: () { changeClubSettings();},
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 50,
                      child: Text("SAVE"),
                    )
                )

              ],
            )
        )
    );
  }
}