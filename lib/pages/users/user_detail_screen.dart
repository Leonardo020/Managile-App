import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylife/blocs/auth/user/user_bloc.dart';
import 'package:mylife/models/auth/user.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = UserBloc();
    _userBloc.add(AuthUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _userBloc,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Scaffold(
              appBar: null,
              backgroundColor: const Color.fromRGBO(252, 253, 239, 1),
              body: state is UserSingleLoaded
                  ? _buildAuthUser(context, state.user)
                  : Container(),
              bottomSheet: state is UserInitial || state is UserLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is UserSingleLoaded
                      ? Container(
                          color: const Color.fromRGBO(252, 253, 239, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Função: ${state.user.role!.name}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      color: Color.fromRGBO(169, 169, 169, 1))),
                              const Divider(thickness: 1),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: Row(children: [
                                  const Icon(
                                    Icons.book_rounded,
                                    color: Color.fromRGBO(169, 169, 169, 1),
                                    size: 30,
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: Text(state.user.role!.description!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Color.fromRGBO(
                                                169, 169, 169, 1))),
                                  )
                                ]),
                              )
                            ],
                          ),
                        )
                      : Container(),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildAuthUser(context, UserModel user) {
  return SafeArea(
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text('Oi, ${user.name}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
              controller: TextEditingController(text: user.email),
              style: const TextStyle(color: Color.fromRGBO(188, 186, 186, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
                ),
                hintText: 'E-mail',
                labelText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white70,
              )),
          const SizedBox(height: 45),
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
            onPressed: () => print("Alterando..."),
          ),
        ],
      ),
    ),
  );
}
