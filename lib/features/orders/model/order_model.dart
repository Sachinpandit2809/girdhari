class OrderModel {
  String clientId;
  String clientName;
  List orders;

  OrderModel(
      {required this.clientId, required this.clientName, required this.orders});
}
