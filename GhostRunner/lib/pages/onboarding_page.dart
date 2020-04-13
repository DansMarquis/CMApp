import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ghostrunner/services/firebase_analytics.dart';
import 'package:ghostrunner/ui/screens/home.dart';
import 'package:ghostrunner/utils/colors.dart';
import 'package:ghostrunner/utils/text_styles.dart';
import 'package:ghostrunner/utils/ui_helpers.dart';
import 'package:ghostrunner/router_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart' as global;

class MyOnboardingPage extends StatefulWidget {
  final SharedPreferences helper;
  final bool flag;
  final String identity;
  MyOnboardingPage(
      {Key key,
      @required this.helper,
      @required this.flag,
      @required this.identity})
      : super(key: key);
  @override
  _MyOnboardingPageState createState() => _MyOnboardingPageState();
}

class _MyOnboardingPageState extends State<MyOnboardingPage> {
  Color dynamicColor = MyColors.white;
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    final pages = [
      Container(
        color: MyColors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 234.0,
                  height: 142.0,
                  child: Image.asset(
                    'assets/logo/CMlogoVertical.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 180.0,
                  height: 180.0,
                  child: Image.asset(
                    'assets/other/mw.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Swipe left to get started!',
                  style: HeadingStyles.white,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: MyColors.dark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    width: 295.0,
                    height: 140.0,
                    child: Image.asset(
                      'assets/other/trail.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 36.0,
                            height: 36.0,
                            child: Image.asset(
                              'assets/fitness_app/eaten.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Run against you or your ghost friends',
                              style: SubHeadingStyles.white,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'escrever aqui cenas',
                              style: BodyStyles.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32.0,
                            height: 38.0,
                            child: Image.asset(
                              'assets/fitness_app/tab_1.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Create a route or explore one made by friends',
                              style: SubHeadingStyles.white,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Escrever aqui mais cenas',
                              style: BodyStyles.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32.0,
                            height: 38.0,
                            child: Image.asset(
                              'assets/fitness_app/tab_2.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'See your stats!',
                              style: SubHeadingStyles.white,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Nao esquecer de escrever aqui coisas',
                              style: BodyStyles.white,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                        height: 50.0,
                    ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Weight (kg)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:                          
                            Container(
                            width:200,
                            child:   TextField(
                               controller: weightController,
                                    onChanged:(String value){
                                      global.weight = double.parse(value);
                                    },
                                  decoration: InputDecoration(
                                    icon: Icon(
                                            Icons.fitness_center ,
                                            color: Colors.blue,
                                            size: 36.0,
                                          ),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '70'
                                  ),
                          )
                          )     
                          )
                        ],
                      ),
                    ),
                  ),
                ]
                ),
                    SizedBox(
                        height: 50.0,
                    ),
                    ButtonTheme(
                    height: 50.0,
                    minWidth: 180.0,
                    child: RaisedButton(
                      child: Text(
                        'Let\'s Go!',
                        style: isColorCurrentlyDark(dynamicColor)
                            ? BodyStyles.black
                            : BodyStyles.white,
                      ),
                      color: isColorCurrentlyDark(dynamicColor)
                          ? MyColors.primary
                          : MyColors.blue,
                      splashColor: isColorCurrentlyDark(dynamicColor)
                          ? MyColors.blue
                          : MyColors.primary,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      onPressed: () async {
                        global.weight = double.parse(weightController.text);
                        //Firestore.instance.collection("users").document().setData({'name' : 'Daniel'});
                        widget.helper.setBool('isFirstLaunchChat', false);
                        widget.helper.setString('uuid', widget.identity);

                        DynamicTheme.of(context).setBrightness(
                            isColorCurrentlyDark(dynamicColor)
                                ? Brightness.dark
                                : Brightness.light);

                        isThemeCurrentlyDark(context)
                            ? logAnalyticsEvent('dark_mode')
                            : logAnalyticsEvent('light_mode');

                       Navigator.of(context).pushReplacementNamed(RouteName.tab);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    return LiquidSwipe(
      pages: pages,
      fullTransitionValue: 350.0,
      enableLoop: false,
      enableSlideIcon: false,
      slideIconWidget: Icon(
        Icons.arrow_back_ios,
        color: dynamicColor,
      ),
    );
  }
}
