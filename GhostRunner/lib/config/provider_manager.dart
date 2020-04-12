import 'package:ghostrunner/model/download_model.dart';
import 'package:ghostrunner/model/favorite_model.dart';
import 'package:ghostrunner/model/local_view_model.dart';
import 'package:ghostrunner/model/song_model.dart';
import 'package:ghostrunner/model/theme_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
  ChangeNotifierProvider<FavoriteModel>(
    create: (context) => FavoriteModel(),
  ),
  ChangeNotifierProvider<DownloadModel>(
    create: (context) => DownloadModel(),
  ),
  ChangeNotifierProvider<SongModel>(
    create: (context) => SongModel(),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
