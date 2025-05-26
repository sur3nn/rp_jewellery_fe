class CartListModel {
  List<CartData>? data;

  CartListModel({this.data});

  CartListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(new CartData.fromJson(v));
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

class CartData {
  String? descrption;
  String? totalPrice;
  int? quantity;

  CartData({this.descrption, this.totalPrice, this.quantity});

  CartData.fromJson(Map<String, dynamic> json) {
    descrption = json['descrption'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descrption'] = this.descrption;
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}
