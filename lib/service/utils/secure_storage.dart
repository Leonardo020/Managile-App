import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future<String> get jwtOrEmpty async {
    var jwt = await _storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }
}
