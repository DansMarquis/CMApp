import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ghostrunner/ui/page/ranking_page/widget/user.dart';
import 'package:ghostrunner/models/user_model.dart';
import 'package:ghostrunner/ui/page/ranking_page/screens/qrcode_main.dart';
import 'package:ghostrunner/global.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List responseList;
  bool _loading;

  getLoading() async {
    setState(() {
      _loading = true;
    });

    int code = 200;
    if (code == 200) {
      setState(() {
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
    getLoading();
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
            icon: Icon(Icons.center_focus_strong),
            onPressed: () {
               Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrCode()
                            ),
                            (Route<dynamic> route) => false);
            },
            tooltip: "",
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
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length == null ? 0 : users.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = users[index];
                  return (user.userID != 0) ? Padding(
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
                  ) :Text("");
                },
              ),
            ),
            Positioned(
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
