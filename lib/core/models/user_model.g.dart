// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  phone: _readPhone(json, 'phone') as String?,
  image: json['image'] as String?,
  avatar: json['avatar'] as String?,
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const FirestoreTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'phone': ?instance.phone,
  'image': ?instance.image,
  'avatar': ?instance.avatar,
  'createdAt': ?const FirestoreTimestampConverter().toJson(instance.createdAt),
  'updatedAt': ?const FirestoreTimestampConverter().toJson(instance.updatedAt),
};
