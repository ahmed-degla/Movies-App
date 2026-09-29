import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/movie_details/domain/entity/cast_entity.dart';

part 'cast_model.g.dart';

@JsonSerializable()
class CastModel {
  const CastModel({
    required this.name,
    required this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);

  Map<String, dynamic> toJson() => _$CastModelToJson(this);

  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(name: 'character_name', defaultValue: '')
  final String characterName;

  @JsonKey(name: 'url_small_image')
  final String? urlSmallImage;

  @JsonKey(name: 'imdb_code', fromJson: _nullableStringFromJson)
  final String? imdbCode;

  CastEntity toEntity() => CastEntity(
    name: name,
    characterName: characterName,
    urlSmallImage: urlSmallImage,
    imdbCode: imdbCode,
  );
}

String? _nullableStringFromJson(Object? value) {
  if (value == null || value is String) return value as String?;
  if (value is num) return value.toString();
  throw FormatException('Invalid cast IMDb code: $value');
}
