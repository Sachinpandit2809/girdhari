import 'package:get/get.dart';

class ProductModel {
  String id;
  String time;
  int? availableQuantity;
  String productName;
  String skuCode;
  String weight;
  String packaging;
  double cost;
  double wholesalePrice;
  double mrp;
  bool is_deleted;
  double totalPrice;

  ProductModel({
    required this.totalPrice,
    required this.id,
    required this.time,
    required this.availableQuantity,
    required this.productName,
    required this.skuCode,
    required this.weight,
    required this.packaging,
    required this.cost,
    required this.wholesalePrice,
    required this.mrp,
    this.is_deleted = false,
  });

  @override
  toString() {
    return 'ProductModel(id: $id, time: $time, availableQuantity: $availableQuantity, productName: $productName, skuCode: $skuCode, weight: $weight, packaging: $packaging, cost: $cost, wholesalePrice: $wholesalePrice, mrp: $mrp)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'availableQuantity': availableQuantity,
      'productName': productName,
      'skuCode': skuCode,
      'weight': weight,
      'packaging': packaging,
      'cost': cost,
      'wholesalePrice': wholesalePrice,
      'mrp': mrp,
      'is_deleted': is_deleted,
      'totalPrice': totalPrice
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        totalPrice: json['totalPrice'],
        availableQuantity: json['availableQuantity'],
        id: json['id'],
        time: json['time'],
        productName: json['productName'],
        skuCode: json['skuCode'],
        weight: json['weight'],
        packaging: json['packaging'],
        cost: json['cost'],
        wholesalePrice: json['wholesalePrice'],
        mrp: json['mrp'],
        is_deleted: json['is_deleted']);
  }
}

class ProductListModel {
  ProductModel productModel;
  bool isSelected;

  ProductListModel({
    required this.productModel,
    this.isSelected = false,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      productModel: ProductModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productModel': productModel.toJson(),
      'isSelected': isSelected,
    };
  }

  setSelected(bool isSelected) {
    isSelected = isSelected;
  }

  ProductListModel copyWith({
    ProductModel? productModel,
    bool? isSelected,
  }) {
    return ProductListModel(
      productModel: productModel ?? this.productModel,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class BillingProductModel extends ProductModel {
  int selectedQuantity;

  BillingProductModel(
      {required super.id,
      this.selectedQuantity = 1,
      required super.time,
      required super.totalPrice,
      required super.availableQuantity,
      required super.productName,
      required super.skuCode,
      required super.weight,
      required super.packaging,
      required super.cost,
      required super.wholesalePrice,
      required super.mrp});

  // double get totalPrice => selectedQuantity * wholesalePrice;
  void increaseQuantity() {
    selectedQuantity += 1;
  }

  void decreaseQuantity() {
    if (selectedQuantity > 1) {
      selectedQuantity -= 1;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'selectedQuantity': selectedQuantity,
      'time': time,
      'availableQuantity': availableQuantity,
      'productName': productName,
      'skuCode': skuCode,
      'weight': weight,
      'packaging': packaging,
      'cost': cost,
      'wholesalePrice': wholesalePrice,
      'mrp': mrp,
      'totalPrice': totalPrice
    };
  }

  factory BillingProductModel.fromJson(Map<String, dynamic> json) {
    return BillingProductModel(
        selectedQuantity: json['selectedQuantity'],
        id: json['id'],
        time: json['time'],
        availableQuantity: json['availableQuantity'],
        productName: json['productName'],
        skuCode: json['skuCode'],
        weight: json['weight'],
        packaging: json['packaging'],
        cost: json['cost'],
        wholesalePrice: json['wholesalePrice'],
        mrp: json['mrp'],
        totalPrice: json['totalPrice']);
  }

  factory BillingProductModel.fromProduct(ProductModel productModel) {
    // ProductModel productModel = ProductModel.fromJson(product);
    return BillingProductModel(
        id: productModel.id,
        time: productModel.time,
        availableQuantity: productModel.availableQuantity,
        productName: productModel.productName,
        skuCode: productModel.skuCode,
        weight: productModel.weight,
        packaging: productModel.packaging,
        cost: productModel.cost,
        wholesalePrice: productModel.wholesalePrice,
        mrp: productModel.mrp,
        totalPrice: productModel.totalPrice);
  }
}
