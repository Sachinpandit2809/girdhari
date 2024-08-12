// class OrderModel {
//   String id;
//   String clientId;
//   String clientName;
//   List<dynamic> orders;
//   String date;

//   OrderModel(
//       {required this.id,
//       required this.clientId,
//       required this.clientName,
//       required this.orders,
//       required this.date});

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'clientId': clientId,
//       'clientName': clientName,
//       'orders': orders,
//       'date': date
//     };
//   }

//   factory OrderModel.fromJson(Map<dynamic, dynamic> json) {
//     return OrderModel(
//         id: json['id'],
//         clientId: json['clientId'],
//         clientName: json['clientName'],
//         orders: json['orders'],
//         date: json['date']);
//   }
// }

import 'package:girdhari/features/client/model/client_model.dart';
import 'package:girdhari/features/product/model/add_product_model.dart';

enum OrderStatus { pending, completed, canceled }

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.canceled:
        return 'Canceled';
      default:
        return '';
    }
  }
}

class OrderModel {
  String id;
  OrderStatus status;
  ClientModel client;
  List<BillingProductModel> orderList;
  DateTime date;
  bool is_deleted;

  double totalAmount = 0.0;

  OrderModel(
      {required this.id,
      this.status = OrderStatus.pending,
      required this.client,
      required this.orderList,
      this.is_deleted = false,
      required this.date}) {
    calculateTotalAmount();
  }

  calculateTotalAmount() {
    totalAmount = 0.0;
    if (orderList.isNotEmpty) {
      for (final product in orderList) {
        totalAmount += product.totalPrice;
      }
    }
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: OrderStatus.values.firstWhere(
          (element) => element.name == json['status'],
          orElse: () => OrderStatus.pending),
      client: ClientModel.fromJson(json['client']),
      orderList: (json['orderList'] as List)
          .map((e) => BillingProductModel.fromJson(e))
          .toList(),
      is_deleted: json['is_deleted'],
      date: DateTime.parse(json['date']),
    );
  }

  OrderModel copyWith({
    String? id,
    OrderStatus? status,
    ClientModel? client,
    List<BillingProductModel>? orderList,
    DateTime? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
      client: client ?? this.client,
      orderList: orderList ?? this.orderList,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.name,
      'client': client.toJson(),
      'orderList': orderList.map((e) => e.toJson()).toList(),
      'date': date.toIso8601String(),
      'totalAmount': totalAmount,
      'is_deleted': is_deleted
    };
  }
}
