import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordEye extends StatefulWidget {
  bool isPasswordVisible;
  PasswordEye({Key? key, required this.isPasswordVisible}) : super(key: key);

  bool get getPasswordState => isPasswordVisible;
  @override
  State<PasswordEye> createState() => _PasswordEyeState();
}

class _PasswordEyeState extends State<PasswordEye> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: IconButton(
          onPressed: () => setState(() {
                widget.isPasswordVisible = !widget.isPasswordVisible;
              }),
          icon: widget.isPasswordVisible
              ? const Icon(FontAwesomeIcons.eyeSlash)
              : const Icon(FontAwesomeIcons.eye)),
    );
  }
}
