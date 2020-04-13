import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ghostrunner/ranking_page/podo/heroitem.dart';
import 'package:ghostrunner/ranking_page/widget/superhero_avatar.dart';
import 'package:ghostrunner/user_model.dart';
import 'package:ghostrunner/trail_model.dart';

import '../../global.dart';

class Details extends StatefulWidget {
  final title;
  final id;
  final img;
  final name;

  Details({Key key, this.title, this.id, this.img, this.name})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _loading;
  User user;
  getHero() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      backgroundColor: Colors.white,
      body: SuperheroDetails(widget: widget, user: user),
    );
  }
}

class SuperheroDetails extends StatefulWidget {
  const SuperheroDetails({
    Key key,
    @required this.widget,
    @required this.user,
  }) : super(key: key);

  final Details widget;
  final User user;

  @override
  _SuperheroDetailsState createState() => _SuperheroDetailsState();
}

class _SuperheroDetailsState extends State<SuperheroDetails> {
  Map<String, bool> _categoryExpansionStateMap = Map<String, bool>();
  bool isExpandedo;

  @override
  void initState() {
    super.initState();

    _categoryExpansionStateMap = {
      "About": true,
      "My Trails": false,
      "Trails Performed": false,
    };

    isExpandedo = false;
  }

  @override
  Widget build(BuildContext context) {
    String trailsToString = "";
    String mytrailsToString = "";
    for (Trail t in trails) {
      for (int i in users[widget.widget.id].trailsPerformed) {
        if (i == t.trailID) {
          trailsToString += t.trailName + "\n ";
        }
      }
    }
    for (Trail t in trails) {
      for (int i in users[widget.widget.id].mytrailsID) {
        if (i == t.trailID) {
          mytrailsToString += t.trailName + "\n ";
        }
      }
    }
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child:         
          Container(
            padding: EdgeInsets.all(26.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SuperheroAvatar(
                  img: widget.widget.img,
                  radius: 50.0,
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  users[widget.widget.id].userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.indigo[900]),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(cardColor: Colors.blue[100]),
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _categoryExpansionStateMap[_categoryExpansionStateMap
                              .keys
                              .toList()[index]] = !isExpanded;
                        });
                      },
                      children: <ExpansionPanel>[
                        ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                  title: Text(
                                "About",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ));
                            },
                            body: About(
                              user: users[widget.widget.id],
                            ),
                            isExpanded: _categoryExpansionStateMap["About"]),
                        ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                  title: Text(
                                "My Trails",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ));
                            },
                            body: MyTrails(
                              str: mytrailsToString,
                            ),
                            isExpanded:
                                _categoryExpansionStateMap["My Trails"]),
                        ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                  title: Text(
                                "Trails Performed",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ));
                            },
                            body: TrailsPerformed(
                              str: trailsToString,
                            ),
                            isExpanded:
                                _categoryExpansionStateMap["Trails Performed"]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        
        
    );
  }
}

class About extends StatelessWidget {
  final User user;

  const About({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Weight".toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.w500, color: Colors.indigo[900]),
          ),
          subtitle: Text(
            "${user.userWeight} kg",
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
        ListTile(
          title: Text(
            "Height".toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.w500, color: Colors.indigo[900]),
          ),
          subtitle: Text(
            "${user.userHeight} m",
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        )
      ],
    );
  }
}

class MyTrails extends StatelessWidget {
  final String str;

  const MyTrails({Key key, @required this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "My Trails".toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.w500, color: Colors.indigo[900]),
          ),
          subtitle: Text(
            str,
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class TrailsPerformed extends StatelessWidget {
  final String str;

  const TrailsPerformed({Key key, @required this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Trails Performed".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          subtitle: Text(
            str,
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
