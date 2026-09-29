import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/movie_details/domain/entity/torrent_entity.dart';

part 'torrent_model.g.dart';

@JsonSerializable()
class TorrentModel {
  const TorrentModel({
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

  factory TorrentModel.fromJson(Map<String, dynamic> json) =>
      _$TorrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentModelToJson(this);

  @JsonKey(defaultValue: '')
  final String url;

  @JsonKey(defaultValue: '')
  final String hash;

  @JsonKey(defaultValue: '')
  final String quality;

  @JsonKey(defaultValue: '')
  final String type;

  @JsonKey(defaultValue: 0)
  final int seeds;

  @JsonKey(defaultValue: 0)
  final int peers;

  @JsonKey(defaultValue: '')
  final String size;

  @JsonKey(name: 'size_bytes', defaultValue: 0)
  final int sizeBytes;

  @JsonKey(name: 'video_codec')
  final String? videoCodec;

  @JsonKey(name: 'bit_depth', fromJson: _stringValueFromJson)
  final String? bitDepth;

  @JsonKey(name: 'audio_channels', fromJson: _stringValueFromJson)
  final String? audioChannels;

  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;

  TorrentEntity toEntity() => TorrentEntity(
    url: url,
    hash: hash,
    quality: quality,
    type: type,
    seeds: seeds,
    peers: peers,
    size: size,
    sizeBytes: sizeBytes,
    videoCodec: videoCodec,
    bitDepth: bitDepth,
    audioChannels: audioChannels,
    dateUploaded: dateUploaded,
  );
}

String? _stringValueFromJson(Object? value) {
  if (value == null || value is String) return value as String?;
  if (value is num) return value.toString();
  throw FormatException('Invalid torrent string value: $value');
}
