import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylife/service/base_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

BaseRepository _repository = BaseRepository();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _repository.redirectPageByAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Aguarde enquanto verificamos algumas coisas..."),
          ],
        )));
  }
}
