import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ghostrunner/utils/text_styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ghostrunner/ui/screens/home.dart';
import '../../global.dart' as global;
import '../../trail_model.dart';
import 'package:toast/toast.dart';
class NewTrailPage extends StatefulWidget {
  @override
  _NewTrailPageState createState() => _NewTrailPageState();
}

class _NewTrailPageState extends State<NewTrailPage>{
  File _image;
  @override
  Widget build(BuildContext context){
    Future getImage(bool camera) async {
      var image;
      if (camera){
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
      }else{
        image = await ImagePicker.pickImage(source: ImageSource.camera);
      }
      

      setState(() {
        _image = image;
      });
    }
    
    Future uploadPic(BuildContext context) async{
      //String fileName = basename(_image.path);
      String fileName = (global.trailID).toString();
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    }

    void newTrail(){
      trails.add(
        Trail(
          trailID : global.trailID,
          trailName: global.trailName,
          address: global.address,
          description:
              global.description,
          locationCoordsStart: LatLng(global.locationCoordsStart.latitude, global.locationCoordsStart.longitude),
          locationCoordsFinish: LatLng(global.locationCoordsFinish.latitude, global.locationCoordsFinish.longitude),
          duration: global.duration,
          velocity: global.velocity,
          distance: global.distance,
          date: global.date,
        )
      );
  }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    )),
                            (Route<dynamic> route) => false);
          }),            
          title: Text('Add New Trail'),
      ), 
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius:100,
                      backgroundColor: Colors.blue,
                      child: ClipOval(
                        child: SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_image!=null)?Image.file(
                                _image,
                                fit: BoxFit.fill,
                                ): 
                                Image(
                                image: AssetImage("assets/photos/1.png"),
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                                ),
                              )
                          ,)
                    )
                  ),
                  Column(
                    children:<Widget>[
                    Padding(
                    padding: EdgeInsets.only(top:50.0),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt,
                            size: 50.0
                            ),
                            onPressed: (){
                              getImage(false);
                            },
                          )
                    ),
                    Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: IconButton(
                      icon: Icon(Icons.collections,
                            size: 50.0
                            ),
                            onPressed: (){
                              getImage(true);
                            },
                          )
                    )
                    ]
                  )

                ],
              ),
              SizedBox(
                height: 40.0,
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
                            child: Text('Trail Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:                          
                            Container(
                            width:300,
                            child:   TextField(
                                    onChanged:(String value){
                                      global.trailName = value;
                                    },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ex: The mountain',
                                  ),
                          )
                          )     
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
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
                            child: Text('Address',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:                          
                            Container(
                            width:300,
                            child:   TextField(
                                    onChanged:(String value){
                                      global.address = value;
                                    },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ex: r do deti'
                                  ),
                          )
                          )     
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
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
                            child: Text('Description',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:                          
                            Container(
                            width:300,
                            child:   TextField(
                                    onChanged:(String value){
                                      global.description = value;
                                    },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ex: Beautifull trail'
                                  ),
                          )
                          )     
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                SizedBox(
                height: 40.0,
              ),   
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[             
                     ButtonTheme(
                      height: 50.0,
                      minWidth: 100.0,
                      child: FlatButton.icon(
                        color: Colors.blue,
                        icon: Icon(
                                Icons.check ,
                            color: Colors.white),
                        label: Text('Add',
                            style: BodyStyles.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        onPressed: () {
                          Toast.show(" New Trail Added!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                          global.trailID +=1;
                          uploadPic(context);
                          newTrail();
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    )),
                            (Route<dynamic> route) => false);

                        }
                      ),
              )   
                ]
              ),   
          ],)
        ))
    );

  }

}