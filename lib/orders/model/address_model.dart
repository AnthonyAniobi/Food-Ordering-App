class UserAdressModel {
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String country;

  UserAdressModel({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  factory UserAdressModel.fromJson(Map<String, dynamic> json) {
    return UserAdressModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
    'address': address,
    'city': city,
    'state': state,
    'country': country,
  };
}
