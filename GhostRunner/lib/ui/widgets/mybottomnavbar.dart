import 'package:flutter/material.dart';
import 'package:ghostrunner/ui/screens/home.dart';
import 'package:ghostrunner/ui/widgets/mybottomnavbaritem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:ghostrunner/classes/dependencies.dart';
import '../../global.dart' as global;
import '../../init_map.dart';

class MyBottomNavBar extends StatefulWidget {
   final SharedPreferences helper;
  final String identity;
  final int act;
  const MyBottomNavBar({
    Key key, this.helper, this.identity,this.act
  }) : super(key: key);

  

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
   final Dependencies dependencies = new Dependencies();
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyBottomNavBarItem(
          active: widget.act,
          id: 0,
          icon: Icons.home,
          text: "Home",
          function: () {
            global.isOnMap = false;
            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    helper: widget.helper,
                                    identity: widget.identity,
                                    )),
                            (Route<dynamic> route) => false);
            setState(() {
              _active = 0;
            });
          },
        ),
        MyBottomNavBarItem(
          active: widget.act,
          id: 1,
          icon: Icons.map,
          text: "Map",
          function: () {
            global.isOnMap = true;
            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapPage(
                                  helper: widget.helper,
                                    identity: widget.identity,
                                    dependencies: dependencies
                                    )),
                            (Route<dynamic> route) => false);
            setState(() {
              _active = 1;
            });
          },
          
        ),
        MyBottomNavBarItem(
          active: widget.act,
          id: 2,
          icon: Icons.trending_up,
          text: "Ranking",
          function: () {
            setState(() {
              _active = 2;
            });
          },
        ),
        MyBottomNavBarItem(
          active: widget.act,
          id: 3,
          icon: Icons.directions_run,
          text: "Profile",
          function: () {
            setState(() {
              _active = 3;
            });
          },
        ),
      ],
    );
  }
}