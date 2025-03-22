class ProfileModel {
  final String name;
  final String email;
  final bool emailVerified;
  final String phone;
  final String address;
  final String avatar;
  final String gender;
  final String createdAt;

  ProfileModel({
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.gender,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'ProfileModel(name: $name, email: $email, emailVerified: $emailVerified, phone: $phone, address: $address, avatar: $avatar, gender: $gender, createdAt: $createdAt)';
  }
}
