
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:ghostrunner/global.dart';
import 'package:ghostrunner/init_map.dart';
import 'package:ghostrunner/trail_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Widget> _getImage(BuildContext context, String image) async {
  Image m;
  final ref = FirebaseStorage.instance.ref().child(image);
  var downloadUrl = await ref.getDownloadURL();
  m = Image.network(
    downloadUrl,
    fit: BoxFit.cover,
    width: 325,
    height: 210,
    alignment: Alignment.center,
  );

  return m;
}


const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(40.581979, -8.080434);

class DetailsScreen extends StatefulWidget {
 final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DetailsState();
}

class DetailsState extends State<DetailsScreen> {


 GoogleMapController mapController;
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<Polyline> polylinesForDistance = [];
  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints;
   PolylinePoints points;
    String _mapStyle;
 
  String googleAPIKey = 'AIzaSyD4Qdvrk2evUhs_EeBG9jVAPAMaya43yrs';
// for my custom marker pins
  BitmapDescriptor sourceIconTrail;
  BitmapDescriptor destinationIcon;

  void showTrails() {
    setState(() {
        _showFirstTrail();
    });
  }

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    points = PolylinePoints();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
    _mapStyle = string;
  });
    setSourceAndDestinationIcons();
  
   
  }
 void _showFirstTrail() {
       setTrail(trails[widget.id].locationCoordsStart, 
                    trails[widget.id].locationCoordsFinish, 
                    widget.id);
  
    
  }
  ////////////////////////////////////////////////////////////////////////////////////////


  moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: trails[widget.id].locationCoordsStart,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  void setSourceAndDestinationIcons() async {
    sourceIconTrail = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/start_map_marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }


  


  @override
  Widget build(BuildContext context) {
      
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: trails[widget.id].locationCoordsStart);

  

    return Scaffold(
      backgroundColor: Color(0xff2446a6),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        
                        Positioned(
                          top:-60,
                          left: 0,
                          right: 0,
                          bottom: 0,                          
                          child:   Container(  
                            height: MediaQuery.of(context).size.height - 50,
                            child: GoogleMap(
                            tiltGesturesEnabled: true,
                            markers: _markers,
                            polylines: _polylines,
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                              mapController.setMapStyle(_mapStyle);
                            showPinsOnMap();
                            }),),
                        
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 44,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 70,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  MyColors.darkBlue,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: destinationsList.length,
                            itemBuilder: (ctx, i) {
                              return GestureDetector(
                                onTap: () => 
                                showTrails(),
                                child: Container(
                                  width: 250,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Image.network(
                                            destinationsList[i].imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          height: 70,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  MyColors.darkBlue,
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                          Text(
                            "${trails[widget.id].trailName}",
                            style: Theme.of(context).textTheme.display1.apply(
                                  color: Colors.red[300],
                                ),
                          ),
                          Text(
                            "${trails[widget.id].date}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .apply(color: Colors.white70),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${trails[widget.id].distance} km",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .apply(color: Colors.white),
                                  ),
                                  Text(
                                    "${trails[widget.id].duration}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .apply(color: Colors.white70),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                     "${trails[widget.id].kcal} kcal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .apply(color: Colors.white),
                                  ),
                                ],
                              ),
                            
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }

 void showPinsOnMap() {
   setState(() {
      _markers.add(Marker(
          markerId: MarkerId('start'),
          draggable: false,
          position: trails[widget.id].locationCoordsStart,
          icon: sourceIconTrail));
           _markers.add(Marker(
          markerId: MarkerId("finish"),
          position: trails[widget.id].locationCoordsFinish,
          icon: destinationIcon));
          moveCamera();
   });
   
  }



  void setTrail(LatLng start, LatLng finish, int id) async {
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
    _polylines.add(Polyline(
        width: 5, // set the width of the polylines
        polylineId: PolylineId("poly"),
        color: Color.fromARGB(125, 0, 0, 255),
        points: polylineCoordinates));
     
    }
     
  }
 



  
}

