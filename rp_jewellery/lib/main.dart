import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/change_pass_bloc/change_pass_bloc.dart';
import 'package:rp_jewellery/business_logic/forgot_pass_bloc/forgot_pass_bloc.dart';
import 'package:rp_jewellery/business_logic/login_bloc/login_bloc.dart';
import 'package:rp_jewellery/business_logic/pass_otp_verify_bloc/pass_otp_verify_bloc.dart';
import 'package:rp_jewellery/business_logic/product_category_bloc/product_category_bloc.dart';
import 'package:rp_jewellery/business_logic/signup_bloc/signup_bloc.dart';
import 'package:rp_jewellery/business_logic/user_otp_verify_bloc/user_otp_verify_bloc.dart';
import 'package:rp_jewellery/firebase_options.dart';
import 'package:rp_jewellery/repository/repository.dart';
import 'package:rp_jewellery/screens/auth/login.dart';
import 'package:rp_jewellery/screens/bottom_navigation/bottom_navigation.dart';
import 'package:rp_jewellery/services/firebase_service.dart';
import 'package:rp_jewellery/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseConfig().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<int?>? getUserId() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('userId');
    }

    final Repository repo = Repository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(repo)),
        BlocProvider<SignupBloc>(create: (context) => SignupBloc(repo)),
        BlocProvider<ProductCategoryBloc>(
            create: (context) => ProductCategoryBloc(repo)),
        BlocProvider<UserOtpVerifyBloc>(
            create: (context) => UserOtpVerifyBloc(repo)),
        BlocProvider<PassOtpVerifyBloc>(
            create: (context) => PassOtpVerifyBloc(repo)),
        BlocProvider<ChangePassBloc>(create: (context) => ChangePassBloc(repo)),
        BlocProvider<ForgotPassBloc>(create: (context) => ForgotPassBloc(repo)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        home: FutureBuilder<int?>(
            future: getUserId(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return const BottomNavigation();
              }
              return Login();
            }),
      ),
    );
  }
}
