import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghostrunner/ranking_page/screens/rank_details.dart';
import 'package:ghostrunner/ranking_page/widget/superhero_avatar.dart';
import 'package:ghostrunner/trail_model.dart';
Future<Widget> _getImage(BuildContext context, String image) async {
  Image m;
  final ref = FirebaseStorage.instance.ref().child(image);
  var downloadUrl = await ref.getDownloadURL();
  m = Image.network(
    downloadUrl,
    fit: BoxFit.cover,
    width: 325,
    height: 210,
    alignment: Alignment.center,
  );

  return m;
}
class SuperHero extends StatelessWidget {
  var id;
  String name;
  String fullName;
  var img;
  var race;
  var gender;
  var hairColor;
  var publisher;

  SuperHero({
    Key key,
    @required this.id,
    @required this.name,
    @required this.fullName,
    @required this.img,
    @required this.race,
    @required this.gender,
    @required this.hairColor,
    @required this.publisher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(builder: (BuildContext context) {
          return Details(img: img, id: id, name: name);
        });

        Navigator.of(context).push(router);
      },
      child: Card(
        elevation:7,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(251, 171, 195, 1),
                Color.fromRGBO(3, 5, 92, 1)
              ]),),
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 12.0,
                  ),
                  SuperheroAvatar(img: img),
                  SizedBox(
                    width: 24.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$name",
                            
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            fullName.isEmpty ? name : fullName,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.map,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                "Trails : $publisher",
                                style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8),
                              ),
                             
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 12.0,
                  ),
                  Icon(
                                Icons.arrow_forward_ios,
                                size: 28.0,
                                color: Colors.white,
                              ),
                ]),
          ),
        )),
      ),
    );
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
