import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylife/blocs/auth/user/user_bloc.dart';
import 'package:mylife/main.dart';
import 'package:mylife/models/auth/user.dart';
import 'package:mylife/pages/components/custom_scaffold_messenger.dart';
import 'package:mylife/pages/login/login_screen.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  late UserBloc _userBloc;
  bool isPasswordVisible = false;

  final _nameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _passwordConfirmationController = TextEditingController();

  @override
  void initState() {
    _userBloc = UserBloc();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  saveUser() {
    _userBloc.add(RegisterUserEvent(UserModel(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmationController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromRGBO(252, 253, 239, 1),
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (BuildContext context) => _userBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserError) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    ErrorScaffoldMessenger.showErrorSnackBar(state.message!));
            }

            if (state is UserSingleLoaded) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(
                      credentials: UserModel(
                          email: _emailController.text,
                          password: _passwordController.text))));
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                    content: Text(
                        'Sucesso ao cadastrar! Logue com o respectivo usuário agora.',
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center),
                    backgroundColor: Color.fromARGB(255, 77, 159, 80)));
            }
          },
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            return Padding(
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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text('Começando!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w600)),
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
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
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
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
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
                      controller: _passwordController,
                      obscureText: isPasswordVisible,
                      textInputAction: TextInputAction.next,
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
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: IconButton(
                                onPressed: () => setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    }),
                                icon: isPasswordVisible
                                    ? const Icon(FontAwesomeIcons.eyeSlash)
                                    : const Icon(FontAwesomeIcons.eye)),
                          ))),
                  const SizedBox(height: 30),
                  TextField(
                      controller: _passwordConfirmationController,
                      obscureText: true,
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
                        side: const BorderSide(
                            color: Color.fromRGBO(188, 186, 186, 1)),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: state is UserLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Cadastrando...',
                                  style: TextStyle(fontSize: 26)),
                            ],
                          )
                        : const Text('Cadastrar',
                            style: TextStyle(fontSize: 26)),
                    onPressed: () => saveUser(),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
