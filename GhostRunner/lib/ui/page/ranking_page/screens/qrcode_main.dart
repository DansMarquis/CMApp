import 'package:flutter/material.dart';
import 'package:ghostrunner/global.dart';

import 'package:ghostrunner/ui/page/ranking_page/screens/qrcode/animated_qr_code_scanner.dart';
import 'package:ghostrunner/ui/page/ranking_page/screens/qrcode/AnimatedQRViewController.dart';
import 'package:ghostrunner/ui/page/ranking_page/screens/rank_qrcode.dart';

class QrCode extends StatefulWidget {
  @override
  QrCodeState createState() => QrCodeState();
}

class QrCodeState extends State<QrCode> {
  final AnimatedQRViewController controller = AnimatedQRViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedQRView(
              squareColor: Colors.green.withOpacity(0.25),
              animationDuration: const Duration(milliseconds: 600),
              onScanBeforeAnimation: (String str) {
                print('Scan Text: $str');
              },
              onScan: (String str) async {
                var router =
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return Stack(
                    children: <Widget>[
                      QrCodeDetails(id: str),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 80,
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
                      ),
                    ],
                  );
                });

                Navigator.of(context).push(router);
              },
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
