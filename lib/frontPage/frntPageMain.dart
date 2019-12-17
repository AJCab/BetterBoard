import 'package:flutter/material.dart';
import 'package:team_k_csc_305/orgViewPage/OrgPageNode.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';

class OrgProfileWidget extends StatefulWidget {
  //OrgProfileWidget({Key key, this.title}) : super(key: key);

  final Club orgProfile;

  OrgProfileWidget(this.orgProfile);

  @override
  _OrgProfileState createState() => _OrgProfileState(orgProfile);
}

class _OrgProfileState extends State<OrgProfileWidget> {
  final Club orgProfile;

  _OrgProfileState(this.orgProfile);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(orgProfile.name),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Picture Container
                Container(
                  color: Colors.grey,
                  constraints: BoxConstraints.expand(height: 100),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child:
                          Image.asset(orgProfile.image, fit: BoxFit.contain)),
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
                //Club summary
                Container(
                    constraints: BoxConstraints.expand(height: 50),
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text(
                          'Summary:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ))),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(orgProfile.summary),
                ),
                Container(
                    constraints: BoxConstraints.expand(height: 50),
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Text(
                          'Upcoming Events:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ))),
              ] //Column children
              ),
        ));
  }
}
