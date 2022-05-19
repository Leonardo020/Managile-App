import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mylife/blocs/auth/login/login_bloc.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/pages/devs/devs_screen.dart';
import 'package:mylife/pages/login/login_screen.dart';
import 'package:mylife/pages/navigator_home.dart';
import 'package:mylife/pages/products/register/product_register.dart';
import 'package:mylife/pages/users/register/user_register_screen.dart';
import 'package:mylife/pages/users/user_detail_screen.dart';
import 'package:mylife/routes/app_routes.dart';

import 'pages/products/products_screen.dart';

const storage = FlutterSecureStorage();
void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
    BlocProvider<ProductBloc>(create: (context) => ProductBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Widget _buildLoading() => const Center(child: CircularProgressIndicator());
    return MaterialApp(
        title: 'My Life',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'SmoochSans',
          textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.5,
              fontSizeDelta: 1.8,
              fontFamily: 'SmoochSans'),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        home: const NavigatorHome(),
        routes: {
          AppRoutes.LOGIN: (ctx) => const LoginScreen(),
          AppRoutes.HOME: (ctx) => const NavigatorHome(),
          AppRoutes.DEVS: (ctx) => DevScreen(loading: _buildLoading()),
          AppRoutes.PRODUCTS: (ctx) => ProductScreen(loading: _buildLoading()),
          AppRoutes.PRODUCTS_REGISTER: (ctx) => const ProductRegisterScreen(),
          AppRoutes.USER_REGISTER: (ctx) => const UserRegisterScreen(),
          AppRoutes.USER_DETAIL: (ctx) => const UserDetailScreen(),
        });
  }
}
