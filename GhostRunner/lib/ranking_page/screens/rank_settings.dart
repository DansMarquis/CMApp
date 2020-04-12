import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghostrunner/ui/page/tab/favorite_page.dart';


class Settings extends StatefulWidget {

  final String title;
  Settings({
    Key key,
    this.title
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isSwitched;

  checkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefTheme = prefs.getString("theme") == null ? "light" : prefs.getString("theme");

    if(prefTheme == "light"){
      if(mounted){
        setState((){
          isSwitched = false;
        });
      }
    }else if(prefTheme == "dark"){
      if(mounted){
        setState((){
          isSwitched = true;
        });
      }
    }else{
      print("This is literally imposible to execute");
    }

  }

  @override
  void initState() {
    super.initState();
    checkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          "Settings",
          style: TextStyle(
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,

      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[

            ListTile(
              title:Text(
                "Dark Mode",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),

              subtitle: Text(
                  "Use the dark mode"
              ),


              trailing: Switch(
                value: isSwitched == null ? false : isSwitched,
                onChanged: (value) async{

                },
                activeColor: Theme.of(context).accentColor,
              ),


            ),
            Divider(),

            SizedBox(height: 10.0),
            Text("Contribute to the Open source project at 'http://www.github.com/JideGuru/FlutterSuperHeroes'"),
          ],
        ),
      ),
    );
  }
}