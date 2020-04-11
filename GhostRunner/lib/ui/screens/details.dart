
import 'package:flutter/material.dart';
import 'package:ghostrunner/global.dart';
import 'package:ghostrunner/init_map.dart';
import 'package:ghostrunner/trail_model.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2446a6),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        
                        Positioned(
                          top:-60,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                                  'assets/tracks/track1.png',),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 0,
                          right: 0,
                          height: 70,
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
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: destinationsList.length,
                            itemBuilder: (ctx, i) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailsScreen(id: i),
                                  ),
                                ),
                                child: Container(
                                  width: 250,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Image.network(
                                            destinationsList[i].imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          height: 70,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),















                          Text(
                            "${trails[id].trailName}",
                            style: Theme.of(context).textTheme.display1.apply(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            "${trails[id].date}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .apply(color: Colors.white70),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${trails[id].distance}km",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .apply(color: Colors.white),
                                  ),
                                  Text(
                                    "${trails[id].duration}min",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .apply(color: Colors.white70),
                                  )
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: CircularProgressIndicator(
                                        value: .25,
                                        backgroundColor: MyColors.lighterBlue,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.brightness_3,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "253kcal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .apply(color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: CircularProgressIndicator(
                                        value: .25,
                                        backgroundColor: MyColors.lighterBlue,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
