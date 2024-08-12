class ExpensesModel {
  String id;
  String venderDetail;
  String expensesTitle;
  double amount;
  String type;
  String expensesDate;
  bool is_deleted;

  ExpensesModel(
      {required this.id,
      required this.venderDetail,
      required this.expensesTitle,
      required this.type,
      required this.amount,
      this.is_deleted = false,
      required this.expensesDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venderDetail': venderDetail,
      'expensesTitle': expensesTitle,
      'amount': amount,
      'type': type,
      'expensesDate': expensesDate,
      'is_deleted': is_deleted
    };
  }

  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
        id: json['id'],
        venderDetail: json['venderDetail'],
        expensesTitle: json['expensesTitle'],
        amount: json['amount'],
        type: json['type'],
        expensesDate: json['expensesDate'],
        is_deleted: json['is_deleted']);
  }
}
