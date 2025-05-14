import 'package:dio/dio.dart';
import 'package:rp_jewellery/model/login_model.dart';
import 'package:rp_jewellery/model/product_category_model.dart';
import 'package:rp_jewellery/model/signup_model.dart';
import 'package:rp_jewellery/model/verify_otp_model.dart';
import 'package:rp_jewellery/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://172.20.10.3:9000/api"));

  Future<SignupModel> signup(String name, String email, String pass) async {
    final Response res = await dio.post('/user/sign-up',
        data: {"firstName": name, "emailId": email, "password": pass});

    return SignupModel.fromJson(res.data);
  }

  Future<VerifyOtpModel> verifyUserOtp(String email, String otp) async {
    final Response res = await dio.get('/user/user-verifyOtp',
        queryParameters: {"emailId": email, "otp": otp});

    final VerifyOtpModel data = VerifyOtpModel.fromJson(res.data);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', data.userId!);
    return data;
  }

  Future<VerifyOtpModel> verifyPassOtp(String email, String otp) async {
    final Response res = await dio.get('/user/user-verifyOtp',
        queryParameters: {"emailId": email, "otp": otp});

    return VerifyOtpModel.fromJson(res.data);
  }

  Future<LoginModel> changePass(String email, String password) async {
    final Response res = await dio.post('/user/forget-password',
        data: {"emailId": email, "password": password});

    return LoginModel.fromJson(res.data);
  }

  Future<LoginModel> forgotPass(String email) async {
    final Response res = await dio.get('/user/send-otp', queryParameters: {
      "emailId": email,
    });

    return LoginModel.fromJson(res.data);
  }

  Future<LoginModel> login(String email, String pass) async {
    final Response res = await dio.post('/user/log-in', data: {
      "emailId": email,
      "password": pass,
      "fcmToken": await FirebaseConfig().getToken()
    });

    return LoginModel.fromJson(res.data);
  }

  Future<ProductCategoryModel> getCategories() async {
    final Response res = await dio.get("/home/product-list");
    return ProductCategoryModel.fromJson(res.data);
  }
}
