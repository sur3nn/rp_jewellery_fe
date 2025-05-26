import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rp_jewellery/model/all_product_model.dart';
import 'package:rp_jewellery/model/cart_list_model.dart';
import 'package:rp_jewellery/model/login_model.dart';
import 'package:rp_jewellery/model/product_category_model.dart';
import 'package:rp_jewellery/model/scheme_list_model.dart';
import 'package:rp_jewellery/model/signup_model.dart';
import 'package:rp_jewellery/model/user_scheme_model.dart';
import 'package:rp_jewellery/model/verify_otp_model.dart';
import 'package:rp_jewellery/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://10.10.13.69:9000/api"));

  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 1;
  }

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
    await prefs.setString('profile', data.profile!);
    await prefs.setString('name', data.name!);
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

  Future<String> addScheme(String name, String amt) async {
    final Response res = await dio
        .post("/scheme/add-schem", data: {"schemeName": name, "amount": amt});
    return res.data["message"];
  }

  Future<String> getGoldPrice() async {
    final Response res = await dio.get("/home/gold-price");
    return res.data["price"].toString();
  }

  Future<String> getSilverPrice() async {
    final Response res = await dio.get("/home/silver-price");
    return res.data["price"].toString();
  }

  Future<String> addProduct(
      {required int product,
      required int material,
      required String desc,
      required String size,
      required int stock,
      required String purity,
      required String price,
      required File image}) async {
    final fileName = image.path.split('/').last;

    // Build form data
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "reqBodys": jsonEncode({
        "product": product,
        "material": material,
        "descrption": desc,
        "stock": stock,
        "size": size,
        "purity": purity,
        "grandTotal": price
      })
    });
    final Response res = await dio.post(
      "/home/add-product",
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          // Add any auth headers if needed
        },
      ),
    );
    return res.data["message"];
  }

  Future<ProductDetailsModel> getAllProducts(int id) async {
    final Response res = await dio
        .get("/home/product-details", queryParameters: {"productId": id});
    return ProductDetailsModel.fromJson(res.data);
  }

  Future<String> addToCart(
    int productId,
    int quantity,
  ) async {
    final Response res = await dio.post("/cart/add-cart", data: {
      "productMaterialId": productId,
      "quantity": quantity,
      "userId": await getUserId()
    });
    return res.data["message"];
  }

  Future<CartListModel> cartList() async {
    final Response res = await dio
        .get("/cart/view-cart", queryParameters: {"userId": await getUserId()});
    return CartListModel.fromJson(res.data);
  }

  Future<SchemeListModel> getSchemes() async {
    final Response res = await dio.get("/scheme");
    return SchemeListModel.fromJson(res.data);
  }

  Future<UserSchemeModel> getUserSchemes() async {
    final Response res = await dio
        .get("/scheme/user", queryParameters: {"userId": await getUserId()});
    return UserSchemeModel.fromJson(res.data);
  }

  Future<UserSchemeModel> selectScheme(int id) async {
    final Response res = await dio.post("/scheme/scheme-user", data: {
      "userId": await getUserId(),
      "yearId": DateTime.now().year,
      "monthId": DateTime.now().month,
      "schemeId": id
    });
    return UserSchemeModel.fromJson(res.data);
  }
}
