class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String district;
  final String address;
  final String phoneNumber;
  final String role;
  final int id;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.district,
    required this.address,
    required this.phoneNumber,
    required this.role,
    required this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      role: json['role'] ?? '',
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'city': city,
      'district': district,
      'address': address,
      'phone_number': phoneNumber,
      'role': role,
      'id': id,
    };
  }
}