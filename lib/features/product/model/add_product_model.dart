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

  ProductModel({
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
  });

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
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
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
    );
  }
}
