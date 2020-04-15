import 'dart:math';
import 'package:flutter/material.dart';

class SpeedTextPainter extends CustomPainter {
    final hourTickMarkLength = 20.0;
    final minuteTickMarkLength = 0.0;
    
    final hourTickMarkWidth = 3.0;
    final minuteTickMarkWidth = 1.5;
    
    final Paint tickPaint;
    final TextPainter textPainter;
    final TextStyle textStyle;
    int end;
    int start;
    double value;
    
    SpeedTextPainter({this.start, this.end, this.value})
        : tickPaint = new Paint(),
            textPainter = new TextPainter(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
            ),
            textStyle = const TextStyle(
                color: Colors.white,
                
                fontSize: 0.0,
            ) {
        tickPaint.color = Colors.white;
    }
    
    @override
    void paint(Canvas canvas, Size size) {
        var tickMarkLength;
        final angle = 2 * pi / 60;
        final radius = size.width / 2;
        canvas.save();
        
        // drawing
        canvas.translate(radius, radius);
        for (var i = 0; i < 60; i++) {
           
            
            //draw the text
            if (i == 15 || i == 5) {
                String label = i == 15 ? start.toString() : this.end.toString();
                canvas.save();
                canvas.translate(i == 15 ? -20.0 : 20.0, -radius + 50.0);
                
                textPainter.text = new TextSpan(
                    text: label,
                    style: textStyle,
                );
                
                //helps make the text painted vertically
                canvas.rotate(-angle * i);
                
                textPainter.layout();
                
                textPainter.paint(canvas,
                    new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
                
                canvas.restore();
            } else if (i == 30) {
                String label = this.value.toStringAsFixed(1);
                canvas.save();
                canvas.translate(0.0, -radius + 10.0);
                
                textPainter.text = new TextSpan(
                    text: label,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                    ),
                );
                canvas.rotate(-angle * i);
                
                textPainter.layout();
                
                textPainter.paint(canvas,
                    new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
                
                canvas.restore();
            }
            
            canvas.rotate(angle);
        }
        
        canvas.restore();
    }
    
    @override
    bool shouldRepaint(SpeedTextPainter oldDelegate) {
        return false;
    }
}
