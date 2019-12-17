import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_k_csc_305/main.dart';

//
class AddEventPage extends StatefulWidget {
  AddEventPage();

  //
  @override AddEventState createState() => AddEventState();
}

//
class AddEventState extends State<AddEventPage> {
  AddEventState();
  //Variables
  TextEditingController nameOfEvent = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> entryError(String errorMsg, BuildContext context) async
  {
    return showDialog<void>(
      context: context,

      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Error making event'),
                Text(
                    errorMsg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkEntry(BuildContext context){

    if(nameOfEvent.text.length == 0 || location.text.length == 0 || time.text.length == 0){
      entryError('Please fill in required fields', context);
      return;
    }

    if(date.text.length != 10 || date.text[2] != "/" || date.text[5] != "/"){
      entryError('Please enter a valid date: MM/DD/YYYY', context);
      return;
    }


    addEventButton();
    Navigator.pop(context);

  }



  void addEventButton(){
   Map<String, String> newEvent = new Map<String, String>();
   newEvent['clubname'] = MyApp.appUser.name;
   newEvent['date'] = date.text;
   newEvent['eventname'] = nameOfEvent.text;
   newEvent['fee'] = cost.text;
   newEvent['location'] = location.text;
   newEvent['summary'] = description.text;
   newEvent['time'] = time.text;


   Firestore.instance.collection('events').document().setData(newEvent);
   print('adding new event');



  }

  @override Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
        ),

        body: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                //NAME OF EVENT//

                SizedBox(height:5),
                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name of Event *',
                              ),
                              controller: nameOfEvent,
                            )
                        )
                      ],
                    )

                ),

                //LOCATION//

                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Location *',
                              ),
                              controller: location,
                            )
                        )
                      ],
                    )

                ),

                //DATE//

                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'MM/DD/YYYY *',
                              ),
                              controller: date,
                            )
                        )
                      ],
                    )

                ),

                //TIME//

                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Time *',
                              ),
                              controller: time,
                            )
                        )
                      ],
                    )

                ),

                //COST//

                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,32),
                    child:

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 310,
                            child:
                            TextField(
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cost',
                              ),
                              controller: cost,
                            )
                        )
                      ],
                    )

                ),

                //DESCRIPTION//

                Container(
                    padding: const EdgeInsets.fromLTRB(32,5,0,15),
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
                        ),

                      ],
                    )

                ),

                //SAVE//
                Text('* Required Fields', style: TextStyle(color: Colors.red),),
                SizedBox(height:10),
                ButtonTheme(
                    minWidth: 200,
                    child: MaterialButton(
                      onPressed: () {
                        checkEntry(context);
                      },
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