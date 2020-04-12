import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghostrunner/ranking_page/screens/rank_home.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>{
 var title = "Superheroes";
  String theme;


  ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[100],
    accentColor: Colors.redAccent,
    backgroundColor: Colors.grey[100],
    textTheme: TextTheme(
      headline: TextStyle(
      ),
      title: TextStyle(
      ),
      body1: TextStyle(
      ),
    ),
  );

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.redAccent,
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      headline: TextStyle(
      ),
      title: TextStyle(
      ),
      body1: TextStyle(
      ),
    ),
  );


  //To Restart app
  Key key = UniqueKey();
  restartApp() {
    setState(() {
      key = UniqueKey();
    });
    checkTheme();
  }



  @override
  void initState() {
    super.initState();
    checkTheme();
  }

  checkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefTheme = prefs.getString("theme") == null ? "light" : prefs.getString("theme");
    print("THEME: $prefTheme");
    setState((){
      theme = prefTheme;
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      title: "$title",
      debugShowCheckedModeBanner: false,
      home: Home(
        title: "$title",
      ),

      theme: theme == "dark" ? dark : light,
    );
  }
}
