import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/torrent_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final torrentdata = Provider.of<TorrentProvider>(context, listen: false);
    torrentdata.getTorrentList();
  }

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url)';
  }

  @override
  Widget build(BuildContext context) {
    final torrent = Provider.of<TorrentProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Get Torrent",
          style:
              TextStyle(fontSize: MediaQuery.of(context).textScaleFactor * 20),
        ),
      ),
      body: Consumer<TorrentProvider>(
        builder: (context, value, child) => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: torrent.torrentList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2.5,
                      color: Color(0xFFF4F4F4),
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              torrent.torrentList[index].imageUrl,
                              height: 160.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    torrent.torrentList[index].title,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible),
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Magnet Link :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: torrent
                                              .torrentList[index].magnet.length,
                                          itemBuilder: (context, i) {
                                            return TextButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                        text: value
                                                            .torrentList[index]
                                                            .magnet[i]
                                                            .magnetLink))
                                                    .then((value) {
                                                  const snackBar = SnackBar(
                                                    content: Text(
                                                        'Magnet Link Copied to Clipboard'),
                                                  ); //only if ->
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                });
                                              },
                                              child: Text(torrent
                                                  .torrentList[index]
                                                  .magnet[i]
                                                  .size),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Torrent File :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: torrent
                                              .torrentList[index].magnet.length,
                                          itemBuilder: (context, i) {
                                            return TextButton(
                                              onPressed: () {
                                                _launchUrl(torrent
                                                    .torrentList[index]
                                                    .torrentFile[index]
                                                    .torrent);
                                              },
                                              child: Text(torrent
                                                  .torrentList[index]
                                                  .torrentFile[i]
                                                  .size),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
