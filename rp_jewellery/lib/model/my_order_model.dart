class MyOrderModel {
  List<OrderData>? data;

  MyOrderModel({this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
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

class OrderData {
  int? orderId;
  String? date;
  String? status;

  List<OrderDetails>? orderDetails;

  OrderData({this.orderId, this.orderDetails});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    date = json['order_date'];
    status = json['order_status'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String? image;
  int? total;
  String? productName;

  OrderDetails({this.image, this.total, this.productName});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    total = json['total'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['total'] = this.total;
    data['product_name'] = this.productName;
    return data;
  }
}
