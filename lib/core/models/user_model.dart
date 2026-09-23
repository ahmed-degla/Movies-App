import 'package:cloud_firestore/cloud_firestore.dart';

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

  /// Factory constructor to create a [UserModel] from a Firestore map.
  factory UserModel.fromFirestore(Map<String, dynamic> json) => UserModel(
        uid: json['uid'] as String? ?? '',
        email: json['email'] as String? ?? '',
        name: json['name'] as String? ?? '',
        phone: json['phone'] as String?,
        image: json['image'] as String?,
        avatar: json['avatar'] as String?,
        createdAt: json['createdAt'] as Timestamp?,
        updatedAt: json['updatedAt'] as Timestamp?,
      );

  final String uid;
  final String email;
  final String name;
  final String? phone;
  final String? image;
  final String? avatar;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  /// Converts the [UserModel] instance to a map for Firestore.
  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'email': email,
        'name': name,
        if (phone != null) 'phone': phone,
        if (image != null) 'image': image,
        if (avatar != null) 'avatar': avatar,
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
      };

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
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
