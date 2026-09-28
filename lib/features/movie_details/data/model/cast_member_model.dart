import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';

class CastMemberModel extends CastMemberEntity {
  const CastMemberModel({
    required super.name,
    required super.characterName,
    required super.avatarImage,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) =>
      CastMemberModel(
        name: json['name']?.toString() ?? '',
        characterName: json['character_name']?.toString() ?? '',
        avatarImage: json['url_small_image']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'character_name': characterName,
    'url_small_image': avatarImage,
  };
}
