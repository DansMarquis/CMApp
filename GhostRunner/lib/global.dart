import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
bool show = true;
bool isOnMap = false;
bool isRunning = false;
String trailName;
String address;
String description;
geo.Position locationCoordsStart;
geo.Position locationCoordsFinish;
String duration;
String velocity = '0';
String distance = '4330';
String date;
int trailID = 4; // 4 by default because there are 4 initial locations created
int dailyTotalTime = 0;
double maxSpeed = 0.0;
double altitude = 0.0;
double dailyDistance = 0.0;
double tempDistance = 0;

class MyColors {
  static Color darkBlue = Color(0xff2446a6),
      lightBlue = Color(0xff3a5fc8),
      lighterBlue = Color(0xff4169d8),
      red = Color(0xfffa9d85),
      reder= Color(0xff992d2b);
}



class User {
  static String fullname = "Cybdom Tech",
      profilePicture =
          "https://cdn.pixabay.com/photo/2019/11/19/21/44/animal-4638598_960_720.jpg";
}

class DestinationModel {
  final String placeName, imageUrl, date, hotelName;
  DestinationModel({this.placeName, this.imageUrl, this.date, this.hotelName});
}

final List<DestinationModel> destinationsList = [
  DestinationModel(
    date: "22 Nov, 2019",
    hotelName: "London Marathon",
    imageUrl: "https://cdn.pixabay.com/photo/2014/09/11/18/23/london-441853_960_720.jpg",
    placeName: "London",
  ),
  DestinationModel(
    date: "22 Nov, 2019",
    hotelName: "Leave Trails",
    imageUrl: "https://cdn.pixabay.com/photo/2013/08/09/05/58/kuala-lumpur-170985_960_720.jpg",
    placeName: "Kuala Lumpur",
  ),
  DestinationModel(
    date: "28 Nov, 2019",
    hotelName: "Center Tour",
    imageUrl: "https://cdn.pixabay.com/photo/2019/08/19/15/13/eiffel-tower-4416700_960_720.jpg",
    placeName: "Paris",
  ),
];
