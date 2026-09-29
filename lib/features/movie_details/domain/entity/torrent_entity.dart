class TorrentEntity {
  const TorrentEntity({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.dateUploaded,
  });

  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String? videoCodec;
  final String? bitDepth;
  final String? audioChannels;
  final String? dateUploaded;

  static const List<String> recommendedTrackers = [
    'udp://glotorrents.pw:6969/announce',
    'udp://tracker.opentrackr.org:1337/announce',
    'udp://torrent.gresille.org:80/announce',
    'udp://tracker.openbittorrent.com:80',
    'udp://tracker.coppersurfer.tk:6969',
    'udp://tracker.leechers-paradise.org:6969',
    'udp://p4p.arenabg.ch:1337',
    'udp://tracker.internetwarriors.net:1337',
  ];

  String createMagnetUrl({required String movieTitle}) {
    final encodedTitle = Uri.encodeQueryComponent(movieTitle);
    final trackerParams = recommendedTrackers
        .map((t) => 'tr=${Uri.encodeQueryComponent(t)}')
        .join('&');
    return 'magnet:?xt=urn:btih:$hash&dn=$encodedTitle&$trackerParams';
  }
}
