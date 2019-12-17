import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  String name;
  String image;
  int id;
  String summary;
  List<Event> events;

  static List<Club> allClubs = new List<Club>();
  static int idTotal = 0;


  Club(DocumentSnapshot document){
    name = document['name'];
    summary = document['summary'];
    image = 'assets/images/URI_Logo.png';
    events = new List<Event>();
    id = idTotal++;
  }

  void addEvent(Event event){
    this.events.add(event);
  }

  void removeEvents(Event event){
    this.events.remove(event);
  }

  List<Event> getEvents(){
    return this.events;
  }


}


class Event{
  String clubname;
  String name;
  String time;
  String location;
  String date;
  String summary;
  //String fee;



  Event(DocumentSnapshot document){
    clubname = document['clubname'];
    name = document['eventname'];
    time = document['time'];
    location = document['location'];
    date = document['date'];
    summary = document['summary'];
    //fee = document['fee'];
  }

}


class User {
  String name;
  String username;
  String password;
  int userType; // 0 for regular user, 1 for Club User

  List<Club> clubs;

  User(this.name, this.username, this.password, this.userType);



}