import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:rider/models/pin_pill_info.dart';
import 'package:rider/pages/about_page.dart';
import 'package:rider/pages/chat_page.dart';
import 'package:rider/services/firebase_analytics.dart';
import 'package:rider/ui/widgets/mybottomnavbar.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/map_styles.dart';
import 'package:rider/utils/text_styles.dart';
import 'package:rider/utils/ui_helpers.dart';
import 'package:rider/widgets/alerts.dart';
import 'package:rider/widgets/emergency_call.dart';
import 'package:rider/widgets/fetching_location.dart';
import 'package:rider/widgets/no_connection.dart';
import 'package:rider/widgets/swipe_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPinPillComponent extends StatefulWidget {

  double pinPillPosition;
  PinInformation currentlySelectedPin;

  MapPinPillComponent({ this.pinPillPosition, this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
        bottom: widget.pinPillPosition,
        right: 0,
        left: 0,
        duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50, height: 50,
                    margin: EdgeInsets.only(left: 10),
                    child: ClipOval(child: Image.asset("assets/driving_pin.png", fit: BoxFit.cover )),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.currentlySelectedPin.locationName, style: TextStyle(color: widget.currentlySelectedPin.labelColor)),
                          Text('Latitude: 40.581979', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('Longitude: -8.080434', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Image.asset("assets/driving_pin.png", width: 50, height: 50),
                  )
                ],
              ),
            ),
          ),
        );
  }

}
//https://maps.googleapis.com/maps/api/directions/json?origin=40.581979,-8.080434&destination=40.611561,-8.101829&mode=driving&key=AIzaSyD4Qdvrk2evUhs_EeBG9jVAPAMaya43yrs