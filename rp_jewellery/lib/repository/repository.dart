import 'package:dio/dio.dart';
import 'package:rp_jewellery/model/login_model.dart';

class Repository {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:9000/api"));

  Future<LoginModel> login(String email, String passsword) async {
    final Response res = await dio.post("/user/log-in",
        data: {"emailId": email, "password": passsword, "fcmToken": ""});
    return LoginModel.fromJson(res.data);
  }
}
