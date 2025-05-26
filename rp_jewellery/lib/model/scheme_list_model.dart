class SchemeListModel {
  List<SchemeData>? data;

  SchemeListModel({this.data});

  SchemeListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SchemeData>[];
      json['data'].forEach((v) {
        data!.add(new SchemeData.fromJson(v));
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

class SchemeData {
  int? id;
  String? name;
  String? amount;

  SchemeData({this.id, this.name, this.amount});

  SchemeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
