import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylife/blocs/auth/login/login_bloc.dart';
import 'package:mylife/pages/components/custom_scaffold_messenger.dart';
import 'package:mylife/pages/navigator_home.dart';
import 'package:mylife/service/utils/secure_storage.dart';

import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  late LoginBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color.fromRGBO(255, 253, 239, 1),
            Color.fromRGBO(252, 253, 239, 1),
            Color.fromARGB(255, 214, 213, 213),
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated)),
      child: Scaffold(
          appBar: null,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: BlocProvider(
            create: (BuildContext context) => _loginBloc,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                      ErrorScaffoldMessenger.showErrorSnackBar(state.message!));
                }

                if (state is LoginLoaded) {
                  SecureStorage()
                      .writeSecureData("jwt", state.authTokenModel.token!);
                  SecureStorage().writeSecureData("expiration",
                      state.authTokenModel.expiresIn!.toIso8601String());
                  final token = await SecureStorage().jwtOrEmpty;
                  if (token.isNotEmpty) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigatorHome()));
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/img/logo.png",
                          ),
                        ),
                        TextField(
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(188, 186, 186, 1)),
                                ),
                                hintText: 'E-mail',
                                labelText: 'E-mail',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                fillColor: Colors.white70,
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  size: 30,
                                ))),
                        const SizedBox(height: 30),
                        TextField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(188, 186, 186, 1)),
                                ),
                                hintText: 'Senha',
                                labelText: 'Senha',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                fillColor: Colors.white70,
                                prefixIcon: const Icon(
                                  Icons.vpn_key,
                                  size: 30,
                                ),
                                suffixIcon: IconButton(
                                  icon: isPasswordVisible
                                      ? const Icon(FontAwesomeIcons.eyeSlash)
                                      : const Icon(FontAwesomeIcons.eye),
                                  onPressed: () => setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  }),
                                ))),
                        const SizedBox(height: 30),
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromRGBO(188, 186, 186, 1)),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: state is LoginProcessLoading
                              ? const SizedBox(
                                  height: 31,
                                  width: 31,
                                  child: CircularProgressIndicator())
                              : const Text('Login',
                                  style: TextStyle(fontSize: 26)),
                          onPressed: () => _loginBloc.add(AttemptLoginEvent(
                              _emailController.text, _passwordController.text)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SizedBox(
                              child: Text("Ou", textAlign: TextAlign.center)),
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromRGBO(188, 186, 186, 1)),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Text('Cadastrar',
                              style: TextStyle(fontSize: 26)),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRoutes.USER_REGISTER),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}
