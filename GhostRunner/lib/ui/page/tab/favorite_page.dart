import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghostrunner/generated/i18n.dart';
import 'package:ghostrunner/model/favorite_model.dart';
import 'package:ghostrunner/model/song_model.dart';
import 'package:ghostrunner/ui/page/player_page.dart';
import 'package:provider/provider.dart';
import 'package:ghostrunner/helper/ui_helper.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>{
  
double currentExplorePercent = 100.0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 12,
        width: screenWidth,
        child: Container(
          height: screenHeight,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Opacity(
                opacity: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        "snack.png",
                        width:133,
                        height: 133,
                      ),
                    ),
                  ],
                ),
              ),
              Opacity(
                      opacity: 0,
                      child: Container(
                        width: screenWidth,
                        height: 134,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 22),
                            ),
                            buildListItem(0, "Authentic\nrestaurant"),
                            buildListItem(1, "Famous\nmonuments"),
                            buildListItem(2, "Weekend\ngetaways"),
                            buildListItem(3, "Authentic\nrestaurant"),
                            buildListItem(4, "Famous\nmonuments"),
                            buildListItem(5, "Weekend\ngetaways"),
                          ],
                        ),
                      )),
              Opacity(
                    opacity: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text("EVENTS",
                                style:
                                    const TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                "snack.png",
                              ),
                              Positioned(
                                  bottom: 26,
                                  left: 24,
                                  child: Text(
                                    "Marshmello Live in Concert",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(bottom:262),
              )
            ],
          ),
        ),
      );
  }
   buildListItem(int index, String name) {
    return Transform.translate(
      offset: Offset(0, index * 127 * (1 - currentExplorePercent)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "snack.png",
            width:127,
            height: 127,
          ),
          Text(
            "Trail Name",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
