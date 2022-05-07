import 'package:flutter/material.dart';
import 'package:mylife/pages/components/custom_app_bar.dart';
import 'package:mylife/pages/components/screens.dart';

class NavigatorHome extends StatefulWidget {
  const NavigatorHome({Key? key}) : super(key: key);

  @override
  State<NavigatorHome> createState() => _NavigatorHomeState();
}

class _NavigatorHomeState extends State<NavigatorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.indigo],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home, size: 35, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Bem-vinda, Bonitona! ;)',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Escolha o que gostaria de gerenciar: ',
                          style: TextStyle(
                              fontSize: 25,
                              height: 2,
                              fontWeight: FontWeight.w600)),
                      GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(15),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 0.88,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        children: screens.map((screen) {
                          return InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(screen['screen']),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1)),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${screen['title']}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                  ),
                                  const SizedBox(height: 15),
                                  screen['icon'].runtimeType == String
                                      ? Image.asset(screen['icon'],
                                          width: 60, height: 60)
                                      : Icon(screen['icon'],
                                          color: screen['iconColor'], size: 38),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
