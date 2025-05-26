class VerifyOtpModel {
  String? message;
  int? userId;
  String? name;
  String? profile;

  VerifyOtpModel({this.message, this.userId, this.name, this.profile});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    name = json['name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['profile'] = this.profile;
    return data;
  }
}
