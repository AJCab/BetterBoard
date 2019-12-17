import 'package:flutter/material.dart';

class Event {
  String clubname;
  String name;
  String time;
  String location;
  String date;
  String summary;
  int fee;



  Event(this.clubname, this.name, this.summary, this.time, this.location, this.date) {
    fee = 0;
    //image = 'assets/images/URI_Logo.png';

  }

  void setName(String name) {
    this.name = name;
  }

  String getName(String name) {
    return this.name;
  }

  void setTime(String time) {
    this.time = time;
  }

  String getTime(String name) {
    return this.time;
  }

  void setSummary(String sum) {
    this.summary = sum;
  }

  String getSummary(String sum) {
    return this.summary;
  }

  void setFee(int fee) {
    this.fee = fee;
  }
}