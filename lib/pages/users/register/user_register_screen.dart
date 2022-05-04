import 'package:flutter/material.dart';
import 'package:mylife/routes/app_routes.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromRGBO(252, 253, 239, 1),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 35),
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(AppRoutes.LOGIN,
                          ModalRoute.withName(AppRoutes.USER_REGISTER)),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text('Começando!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
                ),
                Container()
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              "Insira suas principais informações para iniciarmos nossa gestão!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(122, 120, 120, 1)),
            ),
            const SizedBox(height: 35),
            TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(188, 186, 186, 1)),
                    ),
                    hintText: 'Nome',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      size: 30,
                    ))),
            const SizedBox(height: 30),
            TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(188, 186, 186, 1)),
                    ),
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                    prefixIcon: const Icon(
                      Icons.mail,
                      size: 30,
                    ))),
            const SizedBox(height: 30),
            TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(188, 186, 186, 1)),
                    ),
                    hintText: 'Senha',
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
            TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(188, 186, 186, 1)),
                    ),
                    hintText: 'Confirmar Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                    prefixIcon: const Icon(
                      Icons.check_circle,
                      size: 30,
                    ))),
            const SizedBox(height: 30),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  side:
                      const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text('Cadastrar', style: TextStyle(fontSize: 26)),
              onPressed: () => print("Cadastrando..."),
            )
          ],
        ),
      ),
    );
  }
}
