import 'package:movies/features/movie_details/data/model/json_parsers.dart';
import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';

class CastMemberModel extends CastMemberEntity {
  const CastMemberModel({
    required super.name,
    required super.characterName,
    required super.avatarImage,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) =>
      CastMemberModel(
        name: parseJsonString(json['name']),
        characterName: parseJsonString(json['character_name']),
        avatarImage: parseJsonString(json['url_small_image']),
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'character_name': characterName,
    'url_small_image': avatarImage,
  };
}
