class DateModel {
  String id;
  String date;
  String sellTag;
  int quantity;

  DateModel(
      {required this.id,
      required this.date,
      required this.sellTag,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {'id': id, 'date': date, 'sellTag': sellTag, 'quantity': quantity};
  }

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
        id: json['id'],
        date: json['date'],
        sellTag: json['sellTag'],
        quantity: json['quantity']);
  }
}
