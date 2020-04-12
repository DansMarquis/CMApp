import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ghostrunner/utils/colors.dart';
import 'package:ghostrunner/utils/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghostrunner/config/provider_manager.dart';
import 'package:ghostrunner/config/router_manager.dart';
import 'package:ghostrunner/config/storage_manager.dart';
import 'package:ghostrunner/generated/i18n.dart';
import 'package:ghostrunner/model/local_view_model.dart';
import 'package:ghostrunner/model/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
   Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
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
              theme: ThemeData(
                primarySwatch: Colors.blue,
                
              ),
              onGenerateRoute: Router.generateRoute,
              initialRoute: RouteName.splash,
            );
        /*return MaterialApp(
          title: 'GhostRunner',
          theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
          home: FirstPage(),
        );*/
      },
    );
    
    
  }
  }





 