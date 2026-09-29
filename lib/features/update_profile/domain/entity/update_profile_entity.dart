class UpdateProfileEntity {
  const UpdateProfileEntity({
    required this.name,
    required this.phone,
    required this.avatar,
    required this.requiresPassword,
  });

  final String name;
  final String phone;
  final String? avatar;
  final bool requiresPassword;
}
