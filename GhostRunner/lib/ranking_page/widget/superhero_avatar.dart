import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
}
class SuperheroAvatar extends StatelessWidget {
  final radius;
  final img;

  const SuperheroAvatar({
    Key key,
    @required this.img,
    this.radius = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: new Offset(0.0, 0.0),
                blurRadius: 2.0,
                spreadRadius: 0.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FutureBuilder(
                            future: _getImage(context, "$img"),
                            builder: (context, snapshot) {
                                return Container(
                                  child: snapshot.data,
                                );}
                    )
        
        /*CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            "$img",
          ),
        ),*/
      ),
    );
  }
}
