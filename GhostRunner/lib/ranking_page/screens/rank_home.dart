import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ghostrunner/ranking_page/podo/heroitem.dart';
import 'package:ghostrunner/ranking_page/screens/rank_search.dart';
import 'package:ghostrunner/ranking_page/screens/rank_settings.dart';
import 'package:ghostrunner/ranking_page/widget/superhero.dart';
import 'package:ghostrunner/global.dart' as global;
import 'package:ghostrunner/user_model.dart';

import '../../global.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List responseList;
  bool _loading;

  getHeroes() async {
    setState(() {
      _loading = true;
    });
    var url = 'https://akabab.github.io/superhero-api/api/all.json';
    var res = await http.get(url);
    List decodedJson = jsonDecode(res.body);

    int code = res.statusCode;
    if (code == 200) {
      setState(() {
        responseList = decodedJson;
        _loading = false;
      });
    } else {
      print("Something went wrong");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "${widget.title.toUpperCase()}",
          style: TextStyle(
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              responseList == null
                  ? print("Chill")
                  : showSearch(
                      context: context,
                      delegate: HeroSearch(all: responseList),
                    );
            },
            tooltip: "Search",
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              var router =
                  new MaterialPageRoute(builder: (BuildContext context) {
                return Settings(
                  title: widget.title,
                );
              });

              Navigator.of(context).push(router);
            },
            tooltip: "Search",
          ),
             
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : Stack(
            children: <Widget>[
Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length == null ? 0 : users.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = users[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SuperUser(
                      id: user.userID,
                      name: user.userName,
                      weight: user.userWeight,
                      height: user.userHeight,
                      goal: user.userGoal,
                      mytrails:  user.mytrailsID,
                      trailsperformed:  user.trailsPerformed,
                      img: user.img,
                    ),
                  );
                },
              ),
            ),   Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 80,
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
                        ),
            ],
            
          ),
    );
  }
}
