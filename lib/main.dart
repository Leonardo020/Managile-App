import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mylife/blocs/auth/login/login_bloc.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/pages/splash_screen.dart';
import 'package:mylife/pages/devs/devs_screen.dart';
import 'package:mylife/pages/login/login_screen.dart';
import 'package:mylife/pages/navigator_home.dart';
import 'package:mylife/pages/products/register/product_register.dart';
import 'package:mylife/pages/users/register/user_register_screen.dart';
import 'package:mylife/pages/users/user_detail_screen.dart';
import 'package:mylife/routes/app_routes.dart';

import 'pages/products/products_screen.dart';

Widget _buildLoading() => const Center(child: CircularProgressIndicator());
const storage = FlutterSecureStorage();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
    BlocProvider<ProductBloc>(create: (context) => ProductBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return MaterialApp(
        title: 'My Life',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
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
        home: const SplashScreen(),
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

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {

//   @override
//   void initState() {
//     super.initState();
//     _repository.checkToken().then((value) => {isAuth = value});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _splashScreen(isAuth!);
//   }
// }

// Widget _splashScreen(bool isAuth) {
//   return Stack(
//     children: [
//       // SplashScreen(
//       //   seconds: 5,
//       //   gradientBackground: const LinearGradient(
//       //     begin: Alignment.topRight,
//       //     end: Alignment.bottomLeft,
//       //     colors: [
//       //       Color.fromARGB(255, 43, 72, 185),
//       //       Color.fromARGB(255, 14, 2, 118)
//       //     ],
//       //   ),
//       //   navigateAfterSeconds:
//       //       isAuth ? const NavigatorHome() : const LoginScreen(),
//       //   loaderColor: Colors.transparent,
//       // ),
//       // Container(
//       //   decoration: const BoxDecoration(
//       //     image: DecorationImage(
//       //       image: AssetImage("assets/logo.png"),
//       //       fit: BoxFit.none,
//       //     ),
//       //   ),
//       // ),
//     ],
//   );
// }
