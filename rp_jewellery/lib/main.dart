import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/login_bloc/login_bloc.dart';
import 'package:rp_jewellery/business_logic/product_category_bloc/product_category_bloc.dart';
import 'package:rp_jewellery/firebase_options.dart';
import 'package:rp_jewellery/repository/repository.dart';
import 'package:rp_jewellery/screens/bottom_navigation/bottom_navigation.dart';
import 'package:rp_jewellery/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(Repository())),
        BlocProvider<ProductCategoryBloc>(
            create: (context) => ProductCategoryBloc(Repository())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        home: const BottomNavigation(),
      ),
    );
  }
}
