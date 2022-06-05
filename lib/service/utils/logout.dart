import 'package:mylife/main.dart';
import 'package:mylife/routes/app_routes.dart';
import 'package:mylife/service/utils/secure_storage.dart';

void logout() async {
  await SecureStorage().logout();
  navigatorKey.currentState?.pushReplacementNamed(AppRoutes.LOGIN);
}
