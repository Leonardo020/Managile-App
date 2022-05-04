import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: const Color.fromRGBO(252, 253, 239, 1),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(255, 253, 239, 1),
                Color.fromRGBO(252, 253, 239, 1),
                Color.fromRGBO(254, 255, 246, 0.8),
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
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
                  obscureText: true,
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
                      ))),
              const SizedBox(height: 30),
              MaterialButton(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromRGBO(188, 186, 186, 1)),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text('Login', style: TextStyle(fontSize: 26)),
                onPressed: () => print('Logando...'),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(child: Text("Ou", textAlign: TextAlign.center)),
              ),
              MaterialButton(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromRGBO(188, 186, 186, 1)),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text('Cadastrar', style: TextStyle(fontSize: 26)),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.USER_REGISTER,
                    ModalRoute.withName(AppRoutes.LOGIN)),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromRGBO(188, 186, 186, 1)),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.account_circle),
                    SizedBox(width: 10),
                    Text('Usuário', style: TextStyle(fontSize: 26)),
                  ],
                ),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.USER_DETAIL,
                    ModalRoute.withName(AppRoutes.LOGIN)),
              ),
            ],
          ),
        ));
  }
}
