class SignupModel {
  String? message;
  int? userUniqueKey;

  SignupModel({this.message, this.userUniqueKey});

  SignupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userUniqueKey = json['userUniqueKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userUniqueKey'] = userUniqueKey;
    return data;
  }
}
