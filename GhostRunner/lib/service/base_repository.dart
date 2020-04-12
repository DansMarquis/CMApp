import 'package:ghostrunner/config/net/base_api.dart';
import 'package:ghostrunner/model/song_model.dart';

class BaseRepository {
  /// 获取音乐列表
  static Future fetchSongList(String input, int page) async {
    var response = await http.post('/', data: {
      'input': input,
      'type': 'netease',
      'page': page,
      'filter': 'name',
    });
    return response.data.map<Song>((item) => Song.fromJsonMap(item)).toList();
  }
}
