// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'torrent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TorrentModel _$TorrentModelFromJson(Map<String, dynamic> json) => TorrentModel(
  url: json['url'] as String? ?? '',
  hash: json['hash'] as String? ?? '',
  quality: json['quality'] as String? ?? '',
  type: json['type'] as String? ?? '',
  seeds: (json['seeds'] as num?)?.toInt() ?? 0,
  peers: (json['peers'] as num?)?.toInt() ?? 0,
  size: json['size'] as String? ?? '',
  sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
  videoCodec: json['video_codec'] as String?,
  bitDepth: _stringValueFromJson(json['bit_depth']),
  audioChannels: _stringValueFromJson(json['audio_channels']),
  dateUploaded: json['date_uploaded'] as String?,
);

Map<String, dynamic> _$TorrentModelToJson(TorrentModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
      'type': instance.type,
      'seeds': instance.seeds,
      'peers': instance.peers,
      'size': instance.size,
      'size_bytes': instance.sizeBytes,
      'video_codec': instance.videoCodec,
      'bit_depth': instance.bitDepth,
      'audio_channels': instance.audioChannels,
      'date_uploaded': instance.dateUploaded,
    };
