import 'package:flutter/material.dart';
import 'package:team_k_csc_305/frontPage/FrntViewPage.dart';
import 'package:team_k_csc_305/orgViewPage/orgProfileScreen/orgProfileScreen.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';

/*
Banner node for Org View Page
 */

class FrntPgNode extends StatelessWidget {
  final Event EvntProfile;
  final Color color;

  FrntPgNode(this.EvntProfile, this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        /*children: <Widget>[
              const ListTile(
                leading: Icon(Icons.event),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(children: <Widget>[
                FlatButton(
                  child: const Text('READ MORE'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ]))
            ],
          )),*/
      )),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new FrntPgWidget())),
    );
  }
}
