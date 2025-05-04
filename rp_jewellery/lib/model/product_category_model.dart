class ProductCategoryModel {
  List<ProductCategoryData>? data;

  ProductCategoryModel({this.data});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new ProductCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategoryData {
  int? materialId;
  String? materialName;
  List<ProductDetails>? productDetails;

  ProductCategoryData(
      {this.materialId, this.materialName, this.productDetails});

  ProductCategoryData.fromJson(Map<String, dynamic> json) {
    materialId = json['material_id'];
    materialName = json['material_name'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material_id'] = this.materialId;
    data['material_name'] = this.materialName;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  int? productId;
  String? productName;
  int? productMaterialId;

  ProductDetails({this.productId, this.productName, this.productMaterialId});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productMaterialId = json['product_material_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_material_id'] = this.productMaterialId;
    return data;
  }
}
