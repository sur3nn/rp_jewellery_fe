class ProductDetail {
  final int productId;
  final String productName;
  final int productMaterialId;

  ProductDetail({
    required this.productId,
    required this.productName,
    required this.productMaterialId,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productId: json['product_id'],
      productName: json['product_name'],
      productMaterialId: json['product_material_id'],
    );
  }
}

class MaterialMeta {
  final int materialId;
  final String materialName;
  final List<ProductDetail> productDetails;

  MaterialMeta({
    required this.materialId,
    required this.materialName,
    required this.productDetails,
  });

  factory MaterialMeta.fromJson(Map<String, dynamic> json) {
    return MaterialMeta(
      materialId: json['material_id'],
      materialName: json['material_name'],
      productDetails: (json['product_details'] as List)
          .map((e) => ProductDetail.fromJson(e))
          .toList(),
    );
  }
}
