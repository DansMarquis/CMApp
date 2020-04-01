import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rider/pages/map_view_page.dart';
import 'package:rider/pages/onboarding_page.dart';
import 'package:rider/ui/screens/home.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/first_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin().cancelAll();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        fontFamily: 'AvenirNextRounded',
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        brightness: brightness, // default is light
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'GhostRunner',
          theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
          home: FirstPage(),
        );
      },
    );
  }
  }