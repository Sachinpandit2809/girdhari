

class ProductModel {
  String id;
  String productName;
  String skuCode;
  String weight;
  String packaging;
  double cost;
  double wholesalePrice;
  double mrp;

  ProductModel({
    required this.id,
    required this.productName,
    required this.skuCode,
    required this.weight,
    required this.packaging,
    required this.cost,
    required this.wholesalePrice,
    required this.mrp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'skuCode': skuCode,
      'weight': weight,
      'packaging': packaging,
      'cost': cost,
      'wholesalePrice': wholesalePrice,
      'mrp': mrp,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['productName'],
      skuCode: json['skuCode'],
      weight: json['weight'],
      packaging: json['packaging'],
      cost: json['cost'],
      wholesalePrice: json['wholesalePrice'],
      mrp: json['mrp'],
    );
  }
}
