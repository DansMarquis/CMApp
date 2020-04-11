import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trail {
  int trailID;
  String trailName;
  String address;
  String description;
  String duration;
  String distance;
  String velocity;
  LatLng locationCoordsStart;
  LatLng locationCoordsFinish;
  String date;
  bool myTrail;
  String kcal;

  Trail(
      {
      this.trailID,
      this.myTrail,
      this.trailName,
      this.address,
      this.description,
      this.locationCoordsStart,
      this.locationCoordsFinish,
      this.duration,
      this.distance,
      this.velocity,
      this.kcal,
      this.date});
}

final List<Trail> trails = [
  Trail(
    trailID: 0,
    myTrail: true,
      trailName: 'Dam Trail',
      address: 'Tondela',
      description:
          'Beautiful trail',
      locationCoordsStart: LatLng(40.580355, -8.078904),
      locationCoordsFinish: LatLng(40.579570, -8.068348),
      duration: '00 : 23 : 02',
      velocity: '23',
      distance: '0',
      kcal: '253',
      date: '2020-04-15 - 20:22',
      ),
  Trail(
    trailID: 1,
    myTrail: false,
      trailName: 'OverPass',
      address: 'Tondela',
      description:
          'Beautiful and Hard Trail.',
      locationCoordsStart: LatLng(40.572324, -8.084702),
       locationCoordsFinish: LatLng(40.574247, -8.060773),
      duration: '00 : 23 : 02',
      velocity: '15',
      distance: '0',
      kcal: '253',
      date: '2020-04-15 - 10:22',
      ),
  Trail(
    trailID: 2,
    myTrail: false,
      trailName: 'Third Rail',
      address: 'Tondela',
      description:
          'Beautiful and Hard Trail.',
      locationCoordsStart: LatLng(40.568291, -8.077299),
       locationCoordsFinish: LatLng(40.560689, -8.084705),
      duration: '00 : 53 : 32',
      velocity: '12',
      distance: '0',
      kcal: '253',
      date: '2020-04-15 - 09:22',
      ),
  Trail(
    trailID: 3,
    myTrail: false,
      trailName: 'Hi Collar',
      address: 'Tondela',
      description:
          'Beautiful and Hard Trail.',
      locationCoordsStart: LatLng(40.586690, -8.080808),
 locationCoordsFinish: LatLng(40.585393, -8.073783),
      duration: '01 : 03 : 02',
      velocity: '15',
      distance: '0',
      kcal: '253',
      date: '2020-04-15 - 20:22',
      ),
  Trail(
    trailID: 4,
    myTrail: true,
      trailName: 'Montain',
      address: 'Tondela',
      description:
          'Beautiful and Hard Trail.',
      locationCoordsStart: LatLng(40.568982, -8.094214),
 locationCoordsFinish: LatLng(40.597495, -8.092849),
      duration: '00 : 43 : 52',
      velocity: '25',
      distance: '0',
      kcal: '253',
      date: '2020-04-15 - 14:22',
      )
];

