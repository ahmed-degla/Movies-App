import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel {
  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phone,
    this.image,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final String uid;
  final String email;
  final String name;

  @JsonKey(readValue: _readPhone)
  final String? phone;
  final String? image;
  final String? avatar;

  @FirestoreTimestampConverter()
  final Timestamp? createdAt;

  @FirestoreTimestampConverter()
  final Timestamp? updatedAt;

  Map<String, dynamic> toFirestore() => _$UserModelToJson(this);

  /// Returns a copy of [UserModel] with updated fields.
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? image,
    String? avatar,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    final copy = UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return copy;
  }
}

Object? _readPhone(Map json, String key) =>
    json['phone'] ?? json['phoneNumber'];

class FirestoreTimestampConverter
    implements JsonConverter<Timestamp?, Object?> {
  const FirestoreTimestampConverter();

  @override
  Timestamp? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    if (json is DateTime) return Timestamp.fromDate(json);
    if (json is String) return Timestamp.fromDate(DateTime.parse(json));
    throw FormatException('Invalid Firestore timestamp: $json');
  }

  @override
  Object? toJson(Timestamp? object) => object;
}
