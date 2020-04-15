import 'package:flutter/material.dart';
import 'package:ghostrunner/pages/timer/classes/curent_time.dart';
import 'package:ghostrunner/pages/timer/classes/dependencies.dart';
import 'package:ghostrunner/pages/timer/classes/clock_painter.dart';

class TimerClock extends StatefulWidget {
  final Dependencies dependencies;

  TimerClock(this.dependencies, {Key key}) : super(key: key);

  TimerClockState createState() => TimerClockState();
}

class TimerClockState extends State<TimerClock> {
  CurrentTime currentTime;

  Paint paint;

  @override
  void initState() {
    paint = new Paint();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentTime = widget.dependencies.transformMilliSecondsToTime(
        widget.dependencies.stopwatch.elapsedMilliseconds);

    return CustomPaint(
      painter: ClockPainter(
          lineColor: Colors.lightBlueAccent,
          completeColor: Colors.blueAccent,
          hundreds: currentTime.hundreds,
          seconds: currentTime.seconds,
          minutes: currentTime.minutes,
          hours: currentTime.hours,
          width: 8.0,
          linePaint: paint),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentTime.hours.toString().padLeft(2, '0'),
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Text(
              '${currentTime.minutes.toString().padLeft(2, '0')} : ${currentTime.seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Text(
              currentTime.hundreds.toString().padLeft(2, '0'),
              style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
