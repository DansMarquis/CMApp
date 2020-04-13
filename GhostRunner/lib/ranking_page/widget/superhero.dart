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
class SuperUser extends StatelessWidget {
  int id;
  String name;
  String weight;
  String height;
  String goal;
  List<int> mytrails;
  List<int> trailsperformed;
  String img;
  String trailsToString = "";
  String mytrailsToString = "";
  SuperUser({
    Key key,
    @required this.id,
    @required this.name,
    @required this.weight,
    @required this.height,
    @required this.goal,
    @required this.mytrails,
    @required this.trailsperformed,
    @required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    for(Trail t in trails){
      for(int i in trailsperformed){
        if(i == t.trailID){
          trailsToString += t.trailName+" ";
        }
      }
    }
     for(Trail t in trails){
      for(int i in mytrails){
        if(i == t.trailID){
          mytrailsToString += t.trailName+" ";
        }
      }
    }
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
          image: DecorationImage(
            image: AssetImage("assets/card.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                            
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            mytrailsToString.isEmpty ? "My Trails: none " : (mytrailsToString)
                                                                          .length <
                                                                      13 ?"My Trails: $mytrailsToString" : "My Trails: ${mytrailsToString.substring(0, 10)}" +
                                                                      "...",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.map,
                                size: 18.0,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                "Done : $trailsToString",
                                style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 8),
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
                                color: Colors.indigo[900],
                                
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
