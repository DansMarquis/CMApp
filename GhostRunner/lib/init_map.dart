import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ghostrunner/ui/widgets/mybottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/pin_pill_info.dart';
import 'trail_model.dart';
import 'package:ghostrunner/utils/text_styles.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(40.581979, -8.080434);
const LatLng DEST_LOCATION = LatLng(40.611561, -8.101829);

class MapPage extends StatefulWidget {
  final SharedPreferences helper;
  final String identity;

  const MapPage({Key key, this.helper, this.identity}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
 GoogleMapController mapController;
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'AIzaSyD4Qdvrk2evUhs_EeBG9jVAPAMaya43yrs';
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor sourceIconTrail;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  geo.Position currentLocation;
// a reference to the destination location
  geo.Position destinationLocation;
// wrapper around the location API
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;
  ///////////////////////////////////////////

  GoogleMapController _controller2;

  List<Marker> allMarkers = [];
  geo.Geolocator geolocator = new geo.Geolocator();
  PageController _pageController;
  geo.Position thisTrailStart;
  geo.Position thisTrailFinish;
  int prevPage;
  bool _showTrailOnMap = false;
  void showTrails() {
    setState(() {
      _showTrailOnMap = !_showTrailOnMap;
    });
  }

////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    //////////////////////////////////////////////////////////////
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    //////////////////////////////////////////////////////////////////////////
    // create an instance of Location
    polylinePoints = PolylinePoints();
    currentLocation =
        geo.Position.fromMap({"latitude": 40.581979, "longitude": -8.080434});
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    geolocator.getPositionStream().listen((position) {
      print('Accuracy = ${position.accuracy}');
      print('Altitude = ${position.altitude}');
      print('Speed = ${position.speed}');
      print('SpeedAccuracy = ${position.speedAccuracy}');
      print('Heading = ${position.heading}');
      print('Timestamp = ${position.timestamp}');
      print('Lat = ${position.latitude}');
      print('Long = ${position.longitude}');
      print("------------------------");
      currentLocation = position;
      updatePinOnMap();
    });

    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  void _onScroll() {
    if (_pageController.page.toInt() != prevPage && _showTrailOnMap) {
      _markers.removeWhere((m) => m.markerId.value == 'finish');
      prevPage = _pageController.page.toInt();
      polylineCoordinates.clear();
      setPolylinesTrails(
          trails[_pageController.page.toInt()].locationCoordsStart,
          trails[_pageController.page.toInt()].locationCoordsFinish);
      _markers.add(Marker(
          markerId: MarkerId("finish"),
          draggable: false,
          infoWindow:
              InfoWindow(title:trails[_pageController.page.toInt()].trailName, snippet: 'Finish Line'),
          position: trails[_pageController.page.toInt()].locationCoordsFinish,
          icon: destinationIcon));
      moveCamera();
    }
  }

  moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: trails[_pageController.page.toInt()].locationCoordsStart,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  

//////////////////////////////////////////////////////////////////////////////////////
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
    sourceIconTrail = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/start_map_marker.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    print('getPosition() calling Geolocator.getCurrentPosition()');
    print('getPosition() got position=$currentLocation');
    // hard-coded destination for this example

    destinationLocation = geo.Position.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  _trailsList(index) {
    return Visibility(
        visible: _showTrailOnMap,
        child: Stack(children: [
          Center(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
              height: 210.0,
              width: 325.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -60.0,
                      child: Image.asset(
                        trails[index].thumbNail,
                        fit: BoxFit.cover,
                        width: 325,
                        height: 210,
                        alignment: Alignment.center,
                      ),
                    ),
                    Positioned(
                      bottom: 49,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0, vertical: 15.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, left: 4.0, bottom: 6.0),
                                  child: Text(trails[index].trailName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        RadiantGradientMask(
                                          child: Icon(
                                            Icons.alarm,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "54 min",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        RadiantGradientMask(
                                          child: Icon(
                                            Icons.assistant_photo,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "1324 m",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        RadiantGradientMask(
                                          child: Icon(
                                            Icons.av_timer,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "32 km/h",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "22 Nov, 2019",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          decoration: TextDecoration.underline,
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: true,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.satellite,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                showPinsOnMap();
              },
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              }),
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: trails.length,
                itemBuilder: (BuildContext context, int index) {
                  return _trailsList(index);
                },
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width) / 2 - 68,
              bottom: _showTrailOnMap ? 230 : 65,
              child: ButtonTheme(
                height: 50.0,
                minWidth: 100.0,
                child: FlatButton.icon(
                  color: Colors.blue,
                  icon: Icon(
                      _showTrailOnMap
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      color: Colors.white),
                  label: Text(_showTrailOnMap ? 'Hide Trails' : 'Show Trails',
                      style: BodyStyles.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  onPressed: showTrails,
                ),
              )),
          Positioned(
            bottom: 0,
            height: 70,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: MyBottomNavBar(
                  helper: widget.helper, identity: widget.identity, act: 1),
            ),
          )
        ],
      ),
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/maps/avatar.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/maps/avatar.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = destinationPinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon));
    trails.forEach((element) {
      _markers.add(Marker(
          markerId: MarkerId(element.trailName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.trailName, snippet: 'Start'),
          position: element.locationCoordsStart,
          icon: sourceIconTrail));
    });
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylinesTrails(LatLng start, LatLng finish) async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        start.latitude,
        start.longitude,
        finish.latitude,
        finish.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(125, 0, 0, 255),
            points: polylineCoordinates));
      });
    }
  }

  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(125, 255, 0, 0),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    try {
      if(_showTrailOnMap == false){
        mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      }
      // do this inside the setState() so Flutter gets notified
      // that a widget update is due

      setState(() {
        // updated position
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        sourcePinInfo.location = pinPosition;

        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers.add(Marker(
            markerId: MarkerId('sourcePin'),
            onTap: () {
              setState(() {
                currentlySelectedPin = sourcePinInfo;
                pinPillPosition = 0;
              });
            },
            position: pinPosition, // updated position
            icon: sourceIcon));
      });
    } catch (Exception) {
      return;
    }
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.4,
        colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}
// FOR LATER DISTANCE CALCULATION
/*import 'dart:math' show cos, sqrt, asin;
void main() {
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  List<dynamic> data = [
    {
      "lat": 44.968046,
      "lng": -94.420307
    },{
      "lat": 44.33328,
      "lng": -89.132008
    },{
      "lat": 33.755787,
      "lng": -116.359998
    },{
      "lat": 33.844843,
      "lng": -116.54911
    },{
      "lat": 44.92057,
      "lng": -93.44786
    },{
      "lat": 44.240309,
      "lng": -91.493619
    },{
      "lat": 44.968041,
      "lng": -94.419696
    },{
      "lat": 44.333304,
      "lng": -89.132027
    },{
      "lat": 33.755783,
      "lng": -116.360066
    },{
      "lat": 33.844847,
      "lng": -116.549069
    },
  ];
  double totalDistance = 0;
  for(var i = 0; i < data.length-1; i++){
    totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
  }
  print(totalDistance);
}
*/
