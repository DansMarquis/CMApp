import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trail {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Trail(
      {this.shopName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

final List<Trail> trails = [
  Trail(
      shopName: 'Stumptown Coffee Roasters',
      address: '18 W 29th St',
      description:
          'Coffee bar chain offering house-roasted direct-trade coffee, along with brewing gear & whole beans',
      locationCoords: LatLng(40.745803, -73.988213),
      thumbNail: 'assets/1.png'
      ),
  Trail(
      shopName: 'Andrews Coffee Shop',
      address: '463 7th Ave',
      description:
          'All-day American comfort eats in a basic diner-style setting',
      locationCoords: LatLng(40.751908, -73.989804),
      thumbNail: 'assets/2.png'
      ),
  Trail(
      shopName: 'Third Rail Coffee',
      address: '240 Sullivan St',
      description:
          'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
      locationCoords: LatLng(40.730148, -73.999639),
      thumbNail: 'assets/3.png'
      ),
  Trail(
      shopName: 'Hi-Collar',
      address: '214 E 10th St',
      description:
          'Snazzy, compact Japanese cafe showcasing high-end coffee & sandwiches, plus sake & beer at night.',
      locationCoords: LatLng(40.729515, -73.985927),
      thumbNail: 'assets/1.png'
      ),
  Trail(
      shopName: 'Everyman Espresso',
      address: '301 W Broadway',
      description:
          'Compact coffee & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
      locationCoords: LatLng(40.721622, -74.004308),
      thumbNail: 'assets/2.png'
      )
];

