class ExpensesModel {
  String id;
  String venderDetail;
  String expensesTitle;
  double amount;
  String type;
  String expensesDate;

  ExpensesModel(
      {required this.id,
      required this.venderDetail,
      required this.expensesTitle,
      required this.type,
      required this.amount,
      required this.expensesDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venderDetail': venderDetail,
      'expensesTitle': expensesTitle,
      'amount': amount,
      'type': type,
      'expensesDate': expensesDate
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
    );
  }
}
