import 'package:flutter/material.dart';
import 'package:ghostrunner/generated/i18n.dart';
import 'package:ghostrunner/model/home_model.dart';
import 'package:ghostrunner/model/song_model.dart';
import 'package:ghostrunner/provider/provider_widget.dart';
import 'package:ghostrunner/provider/view_state_widget.dart';
import 'package:ghostrunner/ui/widget/albums_carousel.dart';
import 'package:ghostrunner/anims/record_anim.dart';
import 'package:ghostrunner/ui/widget/for_you_carousel.dart';
import 'package:ghostrunner/ui/page/search_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math' as math;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghostrunner/ui/screens/details.dart';
import 'package:ghostrunner/ui/widgets/mybottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghostrunner/classes/dependencies.dart';
import 'package:ghostrunner/widgets/timer_clock.dart';
import '../../../trail_model.dart';
import '../../../global.dart' as global;

Future<Widget> _getImage(BuildContext context, String image) async {
  Image m;
  final ref = FirebaseStorage.instance.ref().child(image);
  var downloadUrl = await ref.getDownloadURL();
  m = Image.network(
    downloadUrl,
    fit: BoxFit.cover,
  );

  return m;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController controllerRecord;
  Animation<double> animationRecord;
  final _inputController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    controllerRecord = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animationRecord =
        new CurvedAnimation(parent: controllerRecord, curve: Curves.linear);
    animationRecord.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerRecord.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controllerRecord.forward();
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    controllerRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.indigo[900],Colors.indigo[900]]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        "My Daily Stats",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .apply(color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, top: 4),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 48,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 2),
                                                        child: Text(
                                                          'Distance',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            letterSpacing: -0.1,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 28,
                                                            height: 28,
                                                            child: Image.asset(
                                                                'assets/other/meters.gif'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child: Text(
                                                              global
                                                                  .dailyDistance
                                                                  .toString()
                                                                  .substring(
                                                                      0, 3),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child: Text(
                                                              'm',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    -0.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 48,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 2),
                                                        child: Text(
                                                          'Burned',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            letterSpacing: -0.1,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 28,
                                                            height: 28,
                                                            child: Image.asset(
                                                              'assets/other/burned.gif',
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child:
                                                            (global.burned == 0.0)
                                                            ?  Text(
                                                              (global.burned).toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                            :  Text(
                                                              (global.burned).toString().substring(0,5),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    bottom: 3),
                                                            child: Text(
                                                              'Kcal',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    -0.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Center(
                                        child: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[50],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(100.0),
                                                  ),
                                                  border: new Border.all(
                                                      width: 4,
                                                      color: Colors.black
                                                          .withOpacity(0.2)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '234',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24,
                                                        letterSpacing: 0.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Steps',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        color: global
                                                            .MyColors.darkBlue
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CustomPaint(
                                                painter: CurvePainter(
                                                    colors: [
                                                      global.MyColors.darkBlue,
                                                      Colors.blue[300],
                                                      Colors.blue[200]
                                                    ],
                                                    angle: 140 +
                                                        (360 - 140) *
                                                            (1.0 - 1)),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 108,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Time',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.2,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Container(
                                              height: 4,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: ((70 / 2.5)),
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            global.MyColors
                                                                .darkBlue,
                                                            Colors.blue[300],
                                                            Colors.blue[200],
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              hometransformMilliSecondsToTime(
                                                      global.dailyTotalTime) +
                                                  " h:m:s",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Altitude',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: (70 / 1.5),
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                global.MyColors
                                                                    .darkBlue,
                                                                Colors
                                                                    .blue[300],
                                                                Colors
                                                                    .blue[200],
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  (global.altitude)
                                                          .toString()
                                                          .substring(0, 3) +
                                                      " m",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Max Speed',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: (70 / 1.7),
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                global.MyColors
                                                                    .darkBlue,
                                                                Colors
                                                                    .blue[300],
                                                                Colors
                                                                    .blue[200],
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  global.maxSpeed
                                                          .toString()
                                                          .substring(0, 3) +
                                                      " km/ms",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "My Trails",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .apply(color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trails.length,
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      DetailsScreen(id: trails[i].trailID),
                                ),
                              ),
                              child: trails[i].myTrail
                                  ? Container(
                                      width: 150,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 11.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: FutureBuilder(
                                                  future: _getImage(
                                                      context,
                                                      (trails[i].trailID)
                                                          .toString()),
                                                  builder: (context, snapshot) {
                                                    return Container(
                                                      child: snapshot.data,
                                                    );
                                                  }),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9.0,
                                                    vertical: 5.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2,
                                                                  left: 4.0),
                                                          child: Text(
                                                              (trails[i].trailName)
                                                                          .length <
                                                                      13
                                                                  ? "${trails[i].trailName}"
                                                                  : "${trails[i].trailName.substring(0, 10)}" +
                                                                      "...",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        RadiantGradientMask(
                                                          child: Icon(
                                                            Icons.alarm,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Text(
                                                            "${trails[i].duration} ",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  0.0,
                                                              color: global
                                                                  .MyColors
                                                                  .darkBlue,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        RadiantGradientMask(
                                                          child: Icon(
                                                            Icons
                                                                .assistant_photo,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Text(
                                                            "${trails[i].distance} km",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  0.0,
                                                              color: global
                                                                  .MyColors
                                                                  .darkBlue,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        RadiantGradientMask(
                                                          child: Icon(
                                                            Icons.av_timer,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Text(
                                                            "${(trails[i].velocity)}. m/s",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  0.0,
                                                              color: global
                                                                  .MyColors
                                                                  .darkBlue,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2,
                                                                  left: 4.0),
                                                          child: Text(
                                                            "${trails[i].date}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  0.0,
                                                              color: global
                                                                  .MyColors
                                                                  .darkBlue
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            );
                          },
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hometransformMilliSecondsToTime(int milliseconds) {
    int seconds = ((milliseconds / 1000) % 60).toInt();
    int minutes = ((milliseconds / (1000 * 60)) % 60).toInt();
    int hours = ((milliseconds / (1000 * 60 * 60)) % 24).toInt();
    return hours.toString() +
        ":" +
        minutes.toString() +
        ":" +
        seconds.toString();
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.4,
        colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
