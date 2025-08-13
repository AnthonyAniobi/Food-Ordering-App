class DeliveryInformation {
  final String contractName;
  final String contactPhone;
  final String status;
  final String latitude;
  final String longitude;

  DeliveryInformation({
    required this.contractName,
    required this.contactPhone,
    required this.status,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryInformation.fromJson(Map<String, dynamic> json) {
    return DeliveryInformation(
      contractName: json['contractName'],
      contactPhone: json['contactPhone'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
    'contractName': contractName,
    'contactPhone': contactPhone,
    'status': status,
    'latitude': latitude,
    'longitude': longitude,
  };
}
