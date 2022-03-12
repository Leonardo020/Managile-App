import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylife/components/custom_app_bar.dart';
import 'package:mylife/routes/app_routes.dart';

class NavigatorHome extends StatefulWidget {
  const NavigatorHome({Key? key}) : super(key: key);

  @override
  State<NavigatorHome> createState() => _NavigatorHomeState();
}

class _NavigatorHomeState extends State<NavigatorHome> {
  List<Map<String, dynamic>> _screens = [];

  @override
  void initState() {
    _screens = [
      {
        'title': 'Devs',
        'icon': FontAwesomeIcons.laptopCode,
        'screen': AppRoutes.DEVS,
      },
      {
        'title': 'Produtos',
        'icon': 'assets/icons/underwear.png',
        'screen': AppRoutes.PRODUCTS,
      },
      {
        'title': 'Vendas',
        'icon': FontAwesomeIcons.coins,
        'iconColor': Colors.black,
        'screen': AppRoutes.HOME,
      },
      {
        'title': 'Configurações',
        'icon': FontAwesomeIcons.user,
        'iconColor': Colors.black,
        'screen': AppRoutes.HOME,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Home'),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Bem-vinda, Bonitona! ;)',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('Escolha o que quer gerenciar:'),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 500,
                          width: 350,
                          child: GridView(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            children: _screens.map((screen) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () => Navigator.of(context)
                                    .pushNamed(screen['screen']),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                            offset: const Offset(0.1, 0.2)),
                                      ],
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.shade300,
                                            Colors.white,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${screen['title']}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      const SizedBox(height: 15),
                                      screen['icon'].runtimeType == String
                                          ? Image.asset(screen['icon'],
                                              width: 60, height: 60)
                                          : Icon(screen['icon'],
                                              color: screen['iconColor'],
                                              size: 35),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
