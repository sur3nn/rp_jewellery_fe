class UserSchemeModel {
  UserSchemeData? data;

  UserSchemeModel({this.data});

  UserSchemeModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new UserSchemeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserSchemeData {
  String? name;
  String? amount;
  List<PaymentDetails>? paymentDetails;

  UserSchemeData({this.name, this.amount, this.paymentDetails});

  UserSchemeData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetails {
  int? isPaid;
  int? yearId;
  int? monthId;
  int? isAvailable;

  PaymentDetails({this.isPaid, this.yearId, this.monthId, this.isAvailable});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    isPaid = json['isPaid'];
    yearId = json['yearId'];
    monthId = json['MonthId'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPaid'] = this.isPaid;
    data['yearId'] = this.yearId;
    data['MonthId'] = this.monthId;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
