class ClientModel {
  String id;
  String clientName;
  int phoneNumber;
  String address;
  String? referredBy;
  double? dueAmount;
  bool is_deleted;

  ClientModel(
      {required this.id,
      required this.clientName,
      required this.phoneNumber,
      required this.address,
      required this.referredBy,
      this.is_deleted = false,
      this.dueAmount = 0.0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'phoneNumber': phoneNumber,
      'address': address,
      'referredBy': referredBy,
      'dueAmount': dueAmount,
      'is_deleted': is_deleted
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
        id: json['id'],
        clientName: json['clientName'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        referredBy: json['referredBy'],
        dueAmount: json['dueAmount']);
  }
}

// class ClientPaymentModel {
//   DateTime date;
//   double amount;
//   ClientPaymentModel({required this.amount, this.date = DateTime.now()});
// }

class ClientPaymentModel {
  String paymentDate;
  double paymentAmount;

  ClientPaymentModel({
    required this.paymentAmount,
    required this.paymentDate,
  });

  Map<String, dynamic> toJson() {
    return {'paymentDate': paymentDate, 'paymentAmount': paymentAmount};
  }

  factory ClientPaymentModel.fromJson(Map<String, dynamic> json) {
    return ClientPaymentModel(
        paymentAmount: json['paymentAmount'], paymentDate: json['paymentDate']);
  }
}
