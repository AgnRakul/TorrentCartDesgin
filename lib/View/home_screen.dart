import 'package:cached_network_image/cached_network_image.dart';
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
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Get Torrent",
          style: TextStyle(
            fontSize: MediaQuery.of(context).textScaleFactor * 20,
          ),
        ),
      ),
      body: Consumer<TorrentProvider>(
        builder: (context, value, child) => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: value.torrentList.length,
          itemBuilder: (context, index) {
            return TorrentTile(
              index: index,
              torrent: value,
              onTap: () {
                _launchUrl(value.torrentList[index].torrentFile[index].torrent);
              },
            );
          },
        ),
      ),
    );
  }
}

class TorrentTile extends StatelessWidget {
  final int index;
  final TorrentProvider torrent;
  final GestureTapCallback onTap;

  const TorrentTile(
      {Key? key,
      required this.index,
      required this.torrent,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
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
                  child: CachedNetworkImage(
                    imageUrl: torrent.torrentList[index].imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      width: 3,
                      height: 3,
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.red,
                    ),
                    height: 160.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(
                  //   torrent.torrentList[index].imageUrl,
                  //   height: 160.0,
                  //   width: 100.0,
                  //   fit: BoxFit.cover,
                  // ),
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
                            overflow: TextOverflow.visible,
                          ),
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
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    torrent.torrentList[index].magnet.length,
                                itemBuilder: (context, i) {
                                  return TextButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: torrent.torrentList[index]
                                              .magnet[i].magnetLink,
                                        ),
                                      ).then(
                                        (value) {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'Magnet Link Copied to Clipboard'),
                                          ); //only if ->
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      );
                                    },
                                    child: Text(
                                      torrent.torrentList[index].magnet[i].size,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
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
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    torrent.torrentList[index].magnet.length,
                                itemBuilder: (context, i) {
                                  return TextButton(
                                    onPressed: onTap,
                                    child: Text(
                                      torrent.torrentList[index].torrentFile[i]
                                          .size,
                                    ),
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
    );
  }
}
