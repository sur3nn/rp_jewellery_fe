class ProductDetailsModel {
  List<AllProductData>? data;

  ProductDetailsModel({this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllProductData>[];
      json['data'].forEach((v) {
        data!.add(new AllProductData.fromJson(v));
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

class AllProductData {
  String? name;
  int? stock;
  String? size;
  String? descrption;
  String? metal;
  String? purity;
  String? stoneAmount;
  String? makingChangesAmount;
  int? gstPercentage;
  String? grandTotal;
  String? productAmount;
  String? image;
  int? productDetailsId;
  int? productMaterialId;

  AllProductData(
      {this.name,
      this.stock,
      this.size,
      this.descrption,
      this.metal,
      this.purity,
      this.stoneAmount,
      this.makingChangesAmount,
      this.gstPercentage,
      this.grandTotal,
      this.productAmount,
      this.productDetailsId,
      this.image,
      this.productMaterialId});

  AllProductData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stock = json['stock'];
    size = json['size'];
    descrption = json['descrption'];
    metal = json['metal'];
    purity = json['purity'];
    stoneAmount = json['stone_amount'];
    makingChangesAmount = json['making_changes_amount'];
    gstPercentage = json['gst_percentage'];
    grandTotal = json['grand_total'];
    productAmount = json['product_amount'];
    productDetailsId = json['product_details_id'];
    productMaterialId = json['productMaterialId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['stock'] = this.stock;
    data['size'] = this.size;
    data['descrption'] = this.descrption;
    data['metal'] = this.metal;
    data['purity'] = this.purity;
    data['stone_amount'] = this.stoneAmount;
    data['making_changes_amount'] = this.makingChangesAmount;
    data['gst_percentage'] = this.gstPercentage;
    data['grand_total'] = this.grandTotal;
    data['product_amount'] = this.productAmount;
    data['product_details_id'] = this.productDetailsId;
    data['productMaterialId'] = this.productMaterialId;
    data['image'] = this.image;
    return data;
  }
}
