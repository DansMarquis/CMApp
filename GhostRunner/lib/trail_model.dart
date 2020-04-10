import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trail {
  int trailID;
  String trailName;
  String address;
  String description;
  String thumbNail;
  String duration;
  String distance;
  String velocity;
  LatLng locationCoordsStart;
  LatLng locationCoordsFinish;
  String date;

  Trail(
      {
      this.trailID,
      this.trailName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoordsStart,
      this.locationCoordsFinish,
      this.duration,
      this.distance,
      this.velocity,
      this.date});
}

final List<Trail> trails = [
  Trail(
    trailID: 0,
      trailName: 'Dam Trail',
      address: '18 W 29th St',
      description:
          'Beautiful trail',
      locationCoordsStart: LatLng(40.580355, -8.078904),
      locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/1.png',
      duration: '53min',
      velocity: '5km/h',
      distance: '5222m',
      date: '15/04/2020',
      ),
  Trail(
    trailID: 1,
      trailName: 'Andrews Coffee Shop',
      address: '463 7th Ave',
      description:
          'All-day American comfort eats in a basic diner-style setting',
      locationCoordsStart: LatLng(40.572324, -8.084702),
       locationCoordsFinish: LatLng(40.574247, -8.060773),
      thumbNail: 'assets/2.png',
      duration: '53min',
      velocity: '5km/h',
      distance: '5222m',
      date: '15/04/2020',
      ),
  Trail(
    trailID: 2,
      trailName: 'Third Rail Coffee',
      address: '240 Sullivan St',
      description:
          'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
      locationCoordsStart: LatLng(40.568291, -8.077299),
       locationCoordsFinish: LatLng(40.560689, -8.084705),
      thumbNail: 'assets/3.png',
      duration: '53min',
      velocity: '5km/h',
      distance: '5222m',
      date: '15/04/2020',
      ),
  Trail(
    trailID: 3,
      trailName: 'Hi-Collar',
      address: '214 E 10th St',
      description:
          'Snazzy, compact Japanese cafe showcasing high-end coffee & sandwiches, plus sake & beer at night.',
      locationCoordsStart: LatLng(40.586690, -8.080808),
 locationCoordsFinish: LatLng(40.585393, -8.073783),
      thumbNail: 'assets/1.png',
      duration: '53min',
      velocity: '5km/h',
      distance: '5222m',
      date: '15/04/2020',
      ),
  Trail(
    trailID: 4,
      trailName: 'Everyman Espresso',
      address: '301 W Broadway',
      description:
          'Compact coffee & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
      locationCoordsStart: LatLng(40.568982, -8.094214),
 locationCoordsFinish: LatLng(40.597495, -8.092849),
      thumbNail: 'assets/2.png',
      duration: '53min',
      velocity: '5km/h',
      distance: '5222m',
      date: '15/04/2020',
      )
];

