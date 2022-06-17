// To parse this JSON data, do
//
//     final torrentModel = torrentModelFromJson(jsonString);

import 'dart:convert';

List<TorrentModel> torrentModelFromJson(String str) =>
    List<TorrentModel>.from(json.decode(str).map((x) => TorrentModel.fromJson(x)));

String torrentModelToJson(List<TorrentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TorrentModel {
  TorrentModel({
    required this.title,
    required this.imageUrl,
    required this.screenShots,
    required this.magnet,
    required this.torrentFile,
  });

  String title;
  String imageUrl;
  List<String> screenShots;
  List<Magnet> magnet;
  List<TorrentFile> torrentFile;

  factory TorrentModel.fromJson(Map<String, dynamic> json) => TorrentModel(
        title: json["Title"],
        imageUrl: json["ImageUrl"],
        screenShots: List<String>.from(json["ScreenShots"].map((x) => x)),
        magnet: List<Magnet>.from(json["Magnet"].map((x) => Magnet.fromJson(x))),
        torrentFile: List<TorrentFile>.from(json["TorrentFile"].map((x) => TorrentFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "ImageUrl": imageUrl,
        "ScreenShots": List<dynamic>.from(screenShots.map((x) => x)),
        "Magnet": List<dynamic>.from(magnet.map((x) => x.toJson())),
        "TorrentFile": List<dynamic>.from(torrentFile.map((x) => x.toJson())),
      };
}

class Magnet {
  Magnet({
    required this.size,
    required this.magnetLink,
  });

  String size;
  String magnetLink;

  factory Magnet.fromJson(Map<String, dynamic> json) => Magnet(
        size: json["Size"],
        magnetLink: json["MagnetLink"],
      );

  Map<String, dynamic> toJson() => {
        "Size": size,
        "MagnetLink": magnetLink,
      };
}

class TorrentFile {
  TorrentFile({
    required this.size,
    required this.torrent,
  });

  String size;
  String torrent;

  factory TorrentFile.fromJson(Map<String, dynamic> json) => TorrentFile(
        size: json["Size"],
        torrent: json["Torrent"],
      );

  Map<String, dynamic> toJson() => {
        "Size": size,
        "Torrent": torrent,
      };
}
