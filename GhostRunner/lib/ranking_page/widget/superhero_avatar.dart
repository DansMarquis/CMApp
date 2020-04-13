import 'package:flutter/material.dart';

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
          color: Colors.indigo[900],
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.transparent,
          ),
          boxShadow: [
           BoxShadow(
        color: Colors.indigo[900],
        blurRadius: 10.0, // has the effect of softening the shadow
        spreadRadius: 4.0, // has the effect of extending the shadow
        offset: Offset(
          2.0, // horizontal, move right 10
          2.0, // vertical, move down 10
        ),),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage( "assets/users/$img",
          ),
        ),
      ),
    );
  }
}
