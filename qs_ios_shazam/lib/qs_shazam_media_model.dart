class QsShazamMediaModel {
  QsShazamMediaModel({
    required this.shazamID,
    required this.title,
    required this.subtitle,
    required this.artist,
    required this.genres,
    required this.appleMusicID,
    required this.appleMusicURL,
    required this.webURL,
    required this.artworkURL,
    required this.videoURL,
    required this.explicitContent,
    required this.isrc,
  });

  late final String? shazamID;
  late final String? title;
  late final String? subtitle;
  late final String? artist;
  late final List<String>? genres;
  late final String? appleMusicID;
  late final String? appleMusicURL;
  late final String? webURL;
  late final String? artworkURL;
  late final String? videoURL;
  late final bool? explicitContent;
  late final String? isrc;
  late final String? album;
  late final String? releaseDate;

  QsShazamMediaModel.fromJson(Map<String, dynamic> json) {
    shazamID = json['shazamID'];
    title = json['title'];
    subtitle = json['subtitle'];
    artist = json['artist'];
    // genres 字段的类型转换
    if (json['genres'] != null) {
      if (json['genres'] is List) {
        genres = (json['genres'] as List).map((item) => item.toString()).toList();
      } else {
        genres = [];
      }
    } else {
      genres = [];
    }
    appleMusicID = json['appleMusicID'];
    appleMusicURL = json['appleMusicURL'];
    webURL = json['webURL'];
    artworkURL = json['artworkURL'];
    videoURL = json['videoURL'];
    explicitContent = json['explicitContent'];
    isrc = json['isrc'];
    album = json['album'];
    releaseDate = json['releaseDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shazamID'] = shazamID;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['artist'] = artist;
    data['genres'] = genres;
    data['appleMusicID'] = appleMusicID;
    data['appleMusicURL'] = appleMusicURL;
    data['webURL'] = webURL;
    data['artworkURL'] = artworkURL;
    data['videoURL'] = videoURL;
    data['explicitContent'] = explicitContent;
    data['isrc'] = isrc;
    data['album'] = album;
    data['releaseDate'] = releaseDate;
    return data;
  }
}
