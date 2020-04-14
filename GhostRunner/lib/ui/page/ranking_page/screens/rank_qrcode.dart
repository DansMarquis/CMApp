
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ghostrunner/ui/page/ranking_page/widget/user_avatar.dart';
import 'package:ghostrunner/models/user_model.dart';
import 'package:ghostrunner/models/trail_model.dart';
import 'package:ghostrunner/ui/page/runners_page.dart';

class QrCodeDetails extends StatefulWidget {
  final String id;

  QrCodeDetails({Key key, this.id})
      : super(key: key);

  @override
  QrCodeDetailsState createState() => QrCodeDetailsState();
}

class QrCodeDetailsState extends State<QrCodeDetails> {
  bool _loading;
  User userT;
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

    for(User userS in users){
      if(int.parse(widget.id) == userS.userID){
          userT = userS;
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage()
                            ),
                            (Route<dynamic> route) => false);
            }
        ),
        title: Text(userT.userName),
      ),
      backgroundColor: Colors.white,
      body: UserDetails(widget: widget, user: userT),
    );
  }
}

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key key,
    @required this.widget,
    @required this.user,
  }) : super(key: key);

  final QrCodeDetails widget;
  final User user;

  @override
  UserDetailsState createState() => UserDetailsState();
}

class UserDetailsState extends State<UserDetails> {
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
      for (int i in users[int.parse(widget.widget.id)].trailsPerformed) {
        if (i == t.trailID) {
          trailsToString += t.trailName+"\n ";
        }
      }
    }
    for (Trail t in trails) {
      for (int i in users[int.parse(widget.widget.id)].mytrailsID) {
        if (i == t.trailID) {
          mytrailsToString += t.trailName + "\n    Description: "+t.description+"\n ";
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
                UserAvatar(
                  img: widget.user.img,
                  radius: 50.0,
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  widget.user.userName,
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
                              user: widget.user,
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
