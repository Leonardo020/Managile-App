import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylife/routes/app_routes.dart';

List<Map<String, dynamic>> screens = [
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
    'title': 'Categorias',
    'icon': FontAwesomeIcons.buffer,
    'iconColor': Colors.black,
    'screen': AppRoutes.HOME,
  },
  {
    'title': 'Configurações',
    'icon': Icons.settings,
    'iconColor': Colors.black,
    'screen': AppRoutes.HOME,
  },
  {
    'title': 'Meu Perfil',
    'icon': Icons.account_circle,
    'iconColor': Colors.black,
    'screen': AppRoutes.USER_DETAIL,
  }
];
