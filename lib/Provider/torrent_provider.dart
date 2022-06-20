import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Model/torrent_model.dart';
import '../Service/api_service.dart';

class TorrentProvider extends ChangeNotifier {
  List<TorrentModel> torrentList = [];

  Future<void> getTorrentList() async {
    final apiResponse = await ApiService().getTorrentData();

    if (apiResponse!.isNotEmpty) {
      torrentList = apiResponse;
    } else {
      torrentList = [];
    }

    notifyListeners();
  }
}
