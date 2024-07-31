class ClientModel {
  String id;
  String clientName;
  int phoneNumber;
  String address;
  String referredBy;

  ClientModel(
      {required this.id,
      required this.clientName,
      required this.phoneNumber,
      required this.address,
      required this.referredBy});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'phoneNumber': phoneNumber,
      'address': address,
      'referredBy': referredBy
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
        id: json['id'],
        clientName: json['clientName'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        referredBy: json['referredBy']);
  }
}
