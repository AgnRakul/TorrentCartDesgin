import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Model/torrent_model.dart';
import '../Service/api_service.dart';

class TorrentProvider extends ChangeNotifier {
  List<TorrentModel> torrentList = [];

  void getTorrentList() {
    ApiService().getTorrentData().then(
          (value) => {
            if (value!.isNotEmpty)
              {
                torrentList = [...value],
                notifyListeners()
              }
            else
              {torrentList = []}
          },
        );
  }
}
