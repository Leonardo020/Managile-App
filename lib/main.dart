import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/pages/devs/devs_screen.dart';
import 'package:mylife/pages/navigator_home.dart';
import 'package:mylife/pages/products/register/product_register.dart';
import 'package:mylife/routes/app_routes.dart';

import 'pages/products/products_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
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
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'SmoochSans',
          textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.5,
              fontSizeDelta: 1.8,
              fontFamily: 'SmoochSans'),
        ),
        home: const NavigatorHome(),
        routes: {
          AppRoutes.DEVS: (ctx) => DevScreen(loading: _buildLoading()),
          AppRoutes.PRODUCTS: (ctx) => ProductScreen(loading: _buildLoading()),
          AppRoutes.REGISTER_PRODUCTS: (ctx) => const ProductRegisterScreen()
        });
  }
}
