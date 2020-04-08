import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trail {
  String trailName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoordsStart;
  LatLng locationCoordsFinish;

  Trail(
      {this.trailName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoordsStart,
      this.locationCoordsFinish});
}

final List<Trail> trails = [
  Trail(
      trailName: 'Dam Trail',
      address: '18 W 29th St',
      description:
          'Beautiful trail',
      locationCoordsStart: LatLng(40.580355, -8.078904),
      locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/1.png'
      ),
  Trail(
      trailName: 'Andrews Coffee Shop',
      address: '463 7th Ave',
      description:
          'All-day American comfort eats in a basic diner-style setting',
      locationCoordsStart: LatLng(40.572324, -8.084702),
       locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/2.png'
      ),
  Trail(
      trailName: 'Third Rail Coffee',
      address: '240 Sullivan St',
      description:
          'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
      locationCoordsStart: LatLng(40.568291, -8.077299),
       locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/3.png'
      ),
  Trail(
      trailName: 'Hi-Collar',
      address: '214 E 10th St',
      description:
          'Snazzy, compact Japanese cafe showcasing high-end coffee & sandwiches, plus sake & beer at night.',
      locationCoordsStart: LatLng(40.586690, -8.080808),
 locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/1.png'
      ),
  Trail(
      trailName: 'Everyman Espresso',
      address: '301 W Broadway',
      description:
          'Compact coffee & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
      locationCoordsStart: LatLng(40.568982, -8.094214),
 locationCoordsFinish: LatLng(40.579570, -8.068348),
      thumbNail: 'assets/2.png'
      )
];

