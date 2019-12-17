import 'package:flutter/material.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/event.dart' as prefix0;
import 'package:team_k_csc_305/menu.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/eventCard.dart';


class CalendarEvents {

  //This classes sole reason is to get all events that a particular user is interested in
  //and make them into a list. This will then be passed on to the calendar page to insert the events into it.
  static void getCalendarPage(BuildContext context){
    List<Event> _events = new List<Event>();
    List<DocumentSnapshot> _eventSnapshots = new List<DocumentSnapshot>();


    Firestore.instance.collection('interested').where('username', isEqualTo: MyApp.appUser.username).getDocuments()
        .then((results) {
      if (results.documents.length > 0){
        results.documents.forEach((f) {
          Firestore.instance.collection('events').where(
              'clubname', isEqualTo: f['clubname']).getDocuments()
              .then((results2) {
            results2.documents.forEach((doc) {
              _events.add(Event(doc));
              _eventSnapshots.add(doc);
              print(doc);
            });

            print('about to push calendar page');
            Navigator.pop(context);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CalendarView(_events, _eventSnapshots)));
          });
        });
    }else{
        print('about to push calendar page empty');
        Navigator.pop(context);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CalendarView(_events, _eventSnapshots)));
      }

    });

  }

}

class CalendarView extends StatefulWidget{

  List<Event> _events = new List<Event>();
  List<DocumentSnapshot> _eventSnapshots = new List<DocumentSnapshot>();

  CalendarView(List<Event> event, List<DocumentSnapshot> eventSnapshot){
    _events = event;
    _eventSnapshots = eventSnapshot;

  }
  @override
  CalendarPageState createState() => CalendarPageState(_events, _eventSnapshots);

}



class CalendarPageState extends State<CalendarView> {

  CalendarController _calendarController;
  List<Event> _events = new List<Event>();
  Map<DateTime, List<Event>> currentEvents;
  List<DocumentSnapshot> _eventSnapshots = new List<DocumentSnapshot>();
  List<Event> _selectedEvents;

  CalendarPageState(List<Event> event, List<DocumentSnapshot> eventSnapshot){
    final _selectedDay = DateTime.now();
    _calendarController = new CalendarController();

    _selectedEvents = new List<Event>();
    _events = event;
    currentEvents = new Map<DateTime, List<Event>>();
    _eventSnapshots = eventSnapshot;
    addEvents();

  }

  void _onDaySelected(DateTime day, List events) {

    if(events.length > 0) {
      setState(() {
        _selectedEvents = events;
      });
    }else{
      print('here');

      setState(() {
        _selectedEvents = null;
      });
    }
  }


  void viewEvent(Event event){
    print('here');
    EventCardState.showEventDetailPage(_eventSnapshots[_events.indexOf(event)], context);
  }

  void addEvents(){

    int month;
    int day;
    int year;

    for(int i = 0; i < _events.length; i++){

      month = int.parse(_events[i].date.substring(0, 2));//MM
      day = int.parse(_events[i].date.substring(3, 5)); //DD
      year = int.parse(_events[i].date.substring(6, 10));//YYYY

      DateTime current = new DateTime(year, month, day);

      if(currentEvents[current] == null){
        currentEvents[current] = [_events[i]];
      }else{
        currentEvents[current].add(_events[i]);
      }


    }


  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: Menu(),
      appBar: new AppBar(
        title: new Text("Your Calendar"),
      ),
      body: Column(

        children: <Widget>[

                TableCalendar(
                events: currentEvents,
                calendarController: _calendarController,

                onDaySelected: _onDaySelected,

                ),
                Expanded(
                  child: _buildEventList(),
                )

        ],
      ),
    );
  }

  Widget _buildEventList() {

    if(_selectedEvents == null || _selectedEvents == []){
      return Text('No Events Scheduled');
    }
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Center(
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
                        title: new Text(event.clubname +' - ' +event.time),
                        subtitle: new Text(event.name)),
                    ButtonTheme.bar(
                        child: ButtonBar(children: <Widget>[

                          RaisedButton(
                            child: const Text('About'),
                            onPressed: () => {viewEvent(event)},
                            color: Colors.blue,
                            textColor: Colors.white,
                          )
                        ]))
                  ],
                ),
              ),
            ),
          ),
        )
      ))
          .toList(),
    );
  }
}