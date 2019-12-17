import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_k_csc_305/club_configure/club_configure.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:team_k_csc_305/orgViewPage/OrgViewPage.dart';
import 'package:team_k_csc_305/frontPage/FrntViewPage.dart';
import 'Clubs-Users-Events/Clubs-Users-Events.dart';
import 'orgViewPage/OrgPageNode.dart';
import 'loginPage/loginPage.dart';
import 'CalendarPage/calendarView.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {

    if(MyApp.appUser.userType == 1){
    return new Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.lightBlue[900], Colors.blue])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/URI_Logo.png',
                            height: 90, width: 90),
                      ),
                    ),
                    Text(
                      'BetterBoard',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    )
                  ],
                ),
              )),
          CustomListTile(
              Icons.home,
              'Featured',
                  () => {
                Navigator.pop(ctxt),
                Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new FrntViewPage()))
              }),
          CustomListTile(
              Icons.calendar_today,
              'Your Calendar',
                  () => {CalendarEvents.getCalendarPage(ctxt)
              }),
          CustomListTile(
              Icons.search,
              'Browse Clubs',
                  () => {
                Navigator.pop(ctxt),
                Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new OrgViewPage()))
              }),
          CustomListTile(
              Icons.person,
              'Configure Club',
                  () => {
                  GetClubConfig.getClubConfigPage(ctxt)
                }
              ),

          CustomListTile(Icons.lock, 'Log Out', () => {
            Navigator.pop(ctxt),
            Navigator.push(
                ctxt,
                new MaterialPageRoute(
                    builder: (ctxt) => new LoginState()))
          }),
        ],
      ),
    );
  }else{
      return new Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.lightBlue[900], Colors.blue])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/URI_Logo.png',
                              height: 90, width: 90),
                        ),
                      ),
                      Text(
                        'BetterBoard',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      )
                    ],
                  ),
                )),
            CustomListTile(
                Icons.home,
                'Featured',
                    () => {
                  Navigator.pop(ctxt),
                  Navigator.push(
                      ctxt,
                      new MaterialPageRoute(
                          builder: (ctxt) => new FrntViewPage()))
                }),
            CustomListTile(
                Icons.calendar_today,
                'Your Calendar',
                    () => {
                      CalendarEvents.getCalendarPage(ctxt)
                }),
            CustomListTile(
                Icons.search,
                'Browse Clubs',
                    () => {
                  Navigator.pop(ctxt),
                  Navigator.push(
                      ctxt,
                      new MaterialPageRoute(
                          builder: (ctxt) => new OrgViewPage()))
                }),

            CustomListTile(Icons.lock, 'Log Out', () => {
              Navigator.pop(ctxt),
              Navigator.push(
                  ctxt,
                  new MaterialPageRoute(
                      builder: (ctxt) => new LoginState()))
            }),
          ],
        ),
      );
    }
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }

  noSuchMethod(Invocation invocation) {
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }
}

class FrontPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: new AppBar(
        title: new Text("Front Page"),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
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
          ),
          Container(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: <Widget>[
                Text('Welcome ' + MyApp.appUser.name),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 22.0, left: 42.0, right: 42.0),
                  child: Center(child: Text('Front Page View')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}





class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}