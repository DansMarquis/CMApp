import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghostrunner/generated/i18n.dart';
import 'package:ghostrunner/model/download_model.dart';
import 'package:ghostrunner/model/favorite_model.dart';
import 'package:ghostrunner/provider/provider_widget.dart';
import 'package:ghostrunner/ui/page/tab/favorite_page.dart';
import 'package:ghostrunner/ui/page/tab/home_page.dart';
import 'package:ghostrunner/ui/page/tab/mine_page.dart';
import 'package:ghostrunner/init_map.dart';
import 'package:provider/provider.dart';
import 'package:ghostrunner/global.dart'as global;

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  bool show = true;

  List<Widget> pages = <Widget>[
    HomePage(),
    MapPage(),
    FavoritePage(),
    MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
                  PageView.builder(
                    itemBuilder: (ctx, index) => pages[index],
                    itemCount: pages.length,
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        if(index == 1){
                           global.isOnMap = true;
                        }
                        _selectedIndex = index;
                      });
                    },
                  ),
            Positioned(
              bottom: 0,
              height: 70,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: global.show  ? Container(
                  margin: EdgeInsets.all(0.0),
                  color: Colors.transparent,
                  child: BubbleBottomBar(
                    currentIndex: _selectedIndex,
                    backgroundColor: Colors.transparent,
                    onTap: (int index) {
                      _pageController.jumpToPage(index);
                    },
                    items: <BubbleBottomBarItem>[
                      BubbleBottomBarItem(
                        backgroundColor: Colors.black38,
                        icon: Icon(
                          Icons.home,
                          size: 25.0,
                        ),
                        activeIcon: Icon(
                          Icons.home,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ) ,
                      ),
                      BubbleBottomBarItem(
                       backgroundColor: Colors.black38,
                        icon: Icon(
                          Icons.map,
                          size: 25.0,
                        ),
                        activeIcon: Icon(
                          Icons.map,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Map',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      BubbleBottomBarItem(
                       backgroundColor: Colors.black38,
                        icon: Icon(
                          Icons.trending_up,
                          size: 25.0,
                        ),
                        activeIcon: Icon(
                          Icons.trending_up,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Ranking',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      BubbleBottomBarItem(
                      backgroundColor: Colors.black38,
                        icon: Icon(
                          Icons.directions_run,
                          size: 25.0,
                        ),
                        activeIcon: Icon(
                          Icons.directions_run,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    opacity: 1,
                    elevation: 0,
                  ),
                ) : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
