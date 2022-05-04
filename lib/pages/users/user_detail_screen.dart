import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromRGBO(252, 253, 239, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                    child: Text('Oi, Fabiane!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600)),
                  ),
                  Container()
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Aqui estão suas informações pessoais guardadas com todo o carinho!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(122, 120, 120, 1)),
              ),
              const SizedBox(height: 50),
              TextField(
                  readOnly: true,
                  textAlign: TextAlign.center,
                  controller:
                      TextEditingController(text: "fabiane.neves@gmail.com"),
                  style:
                      const TextStyle(color: Color.fromRGBO(188, 186, 186, 1)),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(188, 186, 186, 1)),
                    ),
                    hintText: 'E-mail',
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                        controller: TextEditingController(text: "Feminino"),
                        style: const TextStyle(
                          color: Color.fromRGBO(188, 186, 186, 1),
                        ),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(188, 186, 186, 1)),
                          ),
                          hintText: 'Sexo',
                          labelText: 'Sexo',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70,
                        )),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: "30/06/1983"),
                      style: const TextStyle(
                        color: Color.fromRGBO(188, 186, 186, 1),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(188, 186, 186, 1)),
                        ),
                        hintText: 'Dt. Nasc',
                        labelText: 'Dt. Nasc',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MaterialButton(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.restart_alt_sharp,
                        size: 30, color: Color.fromRGBO(188, 186, 186, 1)),
                    Text('Trocar senha',
                        style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 157, 156, 156)))
                  ],
                ),
                onPressed: () => print("Cadastrando..."),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color.fromRGBO(252, 253, 239, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Função: ADM",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Color.fromRGBO(169, 169, 169, 1))),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Row(children: const [
                Icon(
                  Icons.book_rounded,
                  color: Color.fromRGBO(169, 169, 169, 1),
                  size: 30,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                      "Permissão com todas as funcionalidades desbloqueadas.",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(color: Color.fromRGBO(169, 169, 169, 1))),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
