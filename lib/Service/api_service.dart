import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Model/torrent_model.dart';

class ApiService {
  final _dio = Dio(BaseOptions(
      baseUrl: "https://raw.githubusercontent.com",
      connectTimeout: 5000,
      receiveTimeout: 3000));

  Future<List<TorrentModel>?> getTorrentData() async {
    List<TorrentModel>? torrentModel;
    try {
      Response torrentData = await _dio
          .get("/RakulAgn/TorrentCartDesgin/master/lib/Service/Torrent.json");
      torrentModel = torrentModelFromJson(torrentData.data);
      debugPrint("Status Code: ${torrentData.statusCode}");
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return torrentModel;
  }
}
