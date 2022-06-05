import 'package:flutter/material.dart';
import 'package:mylife/models/auth/user.dart';

class ConfirmPassword extends StatelessWidget {
  final UserModel userModel;
  const ConfirmPassword({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
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
            )),
        onSaved: (value) => userModel.passwordConfirmation = value);
  }
}
