import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:ghostrunner/ui/widgets/mybottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/pin_pill_info.dart';
import 'trail_model.dart';
import 'package:ghostrunner/utils/text_styles.dart';
import 'dart:async';
import 'package:ghostrunner/classes/dependencies.dart';
import 'package:ghostrunner/widgets/timer_clock.dart';
import 'package:toast/toast.dart';
import 'global.dart' as global;
import 'ui/widgets/trailForm.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';
import 'package:ghostrunner/services/speedometer.dart';
import 'package:rxdart/rxdart.dart';


const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(40.581979, -8.080434);
const LatLng DEST_LOCATION = LatLng(40.611561, -8.101829);

class MapPage extends StatefulWidget {
  final SharedPreferences helper;
  final String identity;
   final Dependencies dependencies;

  const MapPage({Key key, this.helper, this.identity, this.dependencies}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  //SPEEDOMETER
  double _lowerValue = 5.0;
  double _upperValue = 15.0;
  int start = 0;
  int end = 20;
  
  int counter = 0;
  
  PublishSubject<double> eventObservable = new PublishSubject();
  //TIMER
  Icon leftButtonIcon;
  Icon rightButtonIcon;

  Color leftButtonColor;
  Color rightButtonColor;

  Timer timer;

  updateTime(Timer timer) {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

 GoogleMapController mapController;
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<Polyline> polylinesForDistance = [];
  List<LatLng> polylineCoordinates = [];
  List<LatLng> ghost = [LatLng(40.5866917 , -8.0807823),
LatLng(40.5869320, -8.0806831  ),  
LatLng(40.5871377 , -8.0806831),
LatLng(40.5871377, -8.0806831),
LatLng(40.5872355 , -8.0800608),
LatLng(40.5873353, -8.0798006),
LatLng(40.5873883 , -8.0796558),
LatLng(40.5874718, -8.0793098),
LatLng(40.5873170, -8.0791381),
LatLng(40.5869748 , -8.0787733),
LatLng(40.5866855 , -8.0784863),
LatLng(40.5864839 , -8.0782396),
LatLng(40.5863372, -8.0780572),
LatLng(40.5861539, -8.0778641),
LatLng(40.5859176, -8.0776709),
LatLng(40.5857343, -8.0773813),
LatLng(40.5856121, -8.0770379),
LatLng(40.5855754, -8.0767697),
LatLng(40.5855510, -8.0764854),
LatLng(40.5854654, -8.076126),
LatLng(40.5854817, -8.0758953),
LatLng(40.5855184  , -8.075552),
LatLng(40.5855184, -8.075552),
LatLng(40.5855347, -8.0752784),
LatLng(40.5854247, -8.0748761),
LatLng(40.5854247, -8.0747312),
LatLng(40.5854002, -8.0746347),
LatLng(40.5853962, -8.0745327),
LatLng(40.5853636, -8.0744094),
LatLng(40.5853636, -8.0744094),
LatLng(40.5853432 , -8.0742216),
LatLng(40.5853432, -8.0742216),
LatLng(40.5852699, -8.0738997),
LatLng(40.5852617, -8.0737656),
LatLng(40.5853473, -8.0737174)];
int ghostCount = 0;
  PolylinePoints polylinePoints;
   PolylinePoints points;
  String googleAPIKey = 'AIzaSyD4Qdvrk2evUhs_EeBG9jVAPAMaya43yrs';
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor sourceIconTrail;
  BitmapDescriptor destinationIcon;
  BitmapDescriptor ghostIcon;
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
  double _currentTrailDistance = 0;
  bool trailGhostSelected = false;
  ///////////////////////////////////////////

  GoogleMapController _controller2;

  List<Marker> allMarkers = [];
  geo.Geolocator geolocator = new geo.Geolocator();
  PageController _pageController;
  geo.Position thisTrailStart;
  geo.Position thisTrailFinish;
  int prevPage;
  bool _showTrailOnMap = false;
  bool _showTimer = false;
  void showTrails() {
    setState(() {
      _showTrailOnMap = !_showTrailOnMap;
      if(_showTrailOnMap){
        _showFirstTrail();
      }
      else{
        _hideTrails();
      }
    });
  }

////////////////////////////////////////////////////
  @override
  void initState() {
    const oneSec = const Duration(seconds:1);
    if (widget.dependencies.stopwatch.isRunning) {
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
    } else {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
    }
    super.initState();
    //////////////////////////////////////////////////////////////
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    //////////////////////////////////////////////////////////////////////////
    // create an instance of Location
    polylinePoints = PolylinePoints();
    points = PolylinePoints();
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
      //position.speed
      new Timer.periodic(oneSec, (Timer t) => eventObservable.add(position.speed));
      if(global.isOnMap == true){
        updatePinOnMap();
      }
        
    
    });

    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  void _onScroll() {
    if(_pageController.page.toInt() == 3){
      trailGhostSelected = true;
    }
    else{
      trailGhostSelected = false;
    }
    if (_pageController.page.toInt() != prevPage && _showTrailOnMap) {
      _markers.removeWhere((m) => m.markerId.value == 'finish');
      prevPage = _pageController.page.toInt();
      polylineCoordinates.clear();
      setPolylinesTrails(
          trails[_pageController.page.toInt()].locationCoordsStart,
          trails[_pageController.page.toInt()].locationCoordsFinish,
          trails[_pageController.page.toInt()].trailID);
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
  void _showFirstTrail() {
      setPolylinesTrails(
          trails[_pageController.page.toInt()].locationCoordsStart,
          trails[_pageController.page.toInt()].locationCoordsFinish,
          trails[_pageController.page.toInt()].trailID);
      _markers.add(Marker(
          markerId: MarkerId("finish"),
          draggable: false,
          infoWindow:
              InfoWindow(title:trails[_pageController.page.toInt()].trailName, snippet: 'Finish Line'),
          position: trails[_pageController.page.toInt()].locationCoordsFinish,
          icon: destinationIcon));
      moveCamera();
    
  }
  void _hideTrails() {
      _markers.removeWhere((m) => m.markerId.value == 'finish');
      prevPage = _pageController.page.toInt();
      polylineCoordinates.clear();
      
    
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
    ghostIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/ghost-pin.png');
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
                                            trails[index].duration,
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
                                            trails[index].distance+"km",
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
                                            trails[index].velocity,
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
                                        trails[index].date,
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
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       final ThemeData somTheme = new ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.black,
          backgroundColor: Colors.grey
      );
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
               
          (!_showTrailOnMap && _showTimer) ? Positioned(
            top: 30.0,
            child: Container(
          height: 170.0,
          width: 170.0,
          child: TimerClock(widget.dependencies),
        ),
          ) : Text(""),
           (!_showTrailOnMap && _showTimer) ? Positioned(
            top: 190.0,
            left: 20,
            child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'playPause',
                        backgroundColor: leftButtonColor,
                        onPressed: startOrStopWatch,
                        child: leftButtonIcon),
                    SizedBox(width: 20.0),
                    FloatingActionButton(
                      heroTag: 'reset',
                        backgroundColor: rightButtonColor,
                        onPressed: saveOrRefreshWatch,
                        child: rightButtonIcon),
                  ],
                )
              ],
            ),
          ),
          ) : Text(""),
          
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
          Visibility(
            visible: !_showTimer,
            child:
          Positioned(
              left: _showTrailOnMap ?  42 : (MediaQuery.of(context).size.width) / 2 - 68,
              bottom: _showTrailOnMap ? 230 : 85,
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
              ))
              ),
              Visibility(
            visible: _showTrailOnMap,
            child:
          Positioned(
              left: (MediaQuery.of(context).size.width) / 2 + 10,
              bottom: 230,
              child: ButtonTheme(
                height: 50.0,
                minWidth: 100.0,
                child: FlatButton.icon(
                  color: Colors.green,
                  icon: Icon( Icons.directions_run,
                      color: Colors.white),
                  label: Text('Start Trail',
                      style: BodyStyles.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  onPressed: () {
                            Toast.show(trails[_pageController.page.toInt()].trailName+" TRAIL STARTED!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                            global.locationCoordsStart = currentLocation;
                             _showTimer = true;
                             _showTrailOnMap = false;
                             _hideTrails();
                             _showFirstTrail();
                            leftButtonIcon = Icon(Icons.pause);
                            leftButtonColor = Colors.red;
                            rightButtonIcon = Icon(
                              Icons.fiber_manual_record,
                              color: Colors.red,);
                            rightButtonColor = Colors.white70;
                            widget.dependencies.stopwatch.start();
                            timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
                             
                    
                          },
                ),
              ))
              ),
              Visibility(
                visible: (!_showTrailOnMap && !_showTimer),
                child:
                Positioned(
                right: 0.0,
                bottom: 85,
                child: RawMaterialButton(
                          onPressed: () {
                            Toast.show("NEW TRAIL STARTED!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                            global.locationCoordsStart = currentLocation;
                             _showTimer = true;
                            leftButtonIcon = Icon(Icons.pause);
                            leftButtonColor = Colors.red;
                            rightButtonIcon = Icon(
                              Icons.fiber_manual_record,
                              color: Colors.red,);
                            rightButtonColor = Colors.white70;
                            widget.dependencies.stopwatch.start();
                            timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
                             
                    
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.blue,
                          padding: const EdgeInsets.all(15.0),
                        ),
                )
              ),
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
          ),
           (!_showTrailOnMap && _showTimer) ?Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: new Padding(
                      padding: new EdgeInsets.all(140.0),
                      child: new SpeedOMeter(start:start, end:end, highlightStart:(_lowerValue/end), highlightEnd:(_upperValue/end), themeData:somTheme, eventObservable: this.eventObservable),
                  ),
          ) : Text(""),
          
         
    
        ],
      ),
    );
  }


startOrStopWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
      widget.dependencies.stopwatch.stop();
      setState(() {});
    } else {
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
      widget.dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
    }
  }

  saveOrRefreshWatch() {
    setState(() {
      if (widget.dependencies.stopwatch.isRunning) {
        widget.dependencies.savedTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                widget.dependencies.stopwatch.elapsedMilliseconds));
        widget.dependencies.stopwatch.reset();
        _showTimer = false;
        global.locationCoordsFinish = currentLocation;
        global.duration = widget.dependencies.savedTimeList[0];
        DateTime now = DateTime.now();
        global.date = DateFormat('yyyy-MM-dd – kk:mm').format(now);
        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewTrailPage()
                            ),
                            (Route<dynamic> route) => false);
      } else {
        widget.dependencies.stopwatch.reset();
        widget.dependencies.savedTimeList.clear();
      }
    });
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    var ghostPosition;
    if(ghostCount <= ghost.length){
      ghostPosition = ghost[ghostCount];
    }
    else{
      ghostPosition = ghost[ghost.length];
    }
    

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
        draggable: true,
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
      
       if(trailGhostSelected && _showTimer){ 
            _markers.add(Marker(
            markerId: MarkerId('ghost'),
            
            position: ghostPosition, // updated position
            icon: ghostIcon));
            ghostCount++;
            }

    trails.forEach((element) {
      _markers.add(Marker(
          markerId: MarkerId(element.trailName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.trailName, snippet: 'Start'),
          position: element.locationCoordsStart,
          icon: sourceIconTrail));
    });
  }

  void setPolylinesTrails(LatLng start, LatLng finish, int id) async {
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
   trails[id].distance = getDistance(polylineCoordinates).toStringAsFixed(3);
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(125, 0, 0, 255),
            points: polylineCoordinates));
      });
    }
  }
 
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  double getDistance(List<LatLng> polylineCoordinates){

  double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(polylineCoordinates[i].latitude, polylineCoordinates[i].longitude, polylineCoordinates[i+1].latitude, polylineCoordinates[i+1].longitude);
    }
    return totalDistance;
  }

  void updatePinOnMap() async{
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
         var ghostPosition;
          if(ghostCount <= ghost.length){
            ghostPosition = ghost[ghostCount];
          }
          else{
            ghostPosition = ghost[ghost.length];
          }

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
            
          if(trailGhostSelected && _showTimer){ 
            _markers.removeWhere((m) => m.markerId.value == 'ghost');
            _markers.add(Marker(
            markerId: MarkerId('ghost'),
            
            position: ghostPosition, // updated position
            icon: ghostIcon));
            ghostCount++;
            }
       
      
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
