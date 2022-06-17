import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Model/torrent_model.dart';

class ApiService {
  final url =
      "https://raw.githubusercontent.com/RakulAgn/Plans/main/Torrent.json?token=GHSAT0AAAAAABVQ4ENB5IAG3M6U7TWWGZIGYVFT6IQ";

  Future<List<TorrentModel>?> getTorrentData() async {
    try {
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode == 200) {
        final torrentModel = torrentModelFromJson(resp.body);
        log(resp.body);
        return torrentModel;
      } else {
        throw Exception("Failed to get Torrent Data");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

