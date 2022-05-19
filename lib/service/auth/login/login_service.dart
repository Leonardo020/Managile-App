import 'package:mylife/models/auth/auth_token.dart';
import 'package:mylife/service/auth/login/login_repository.dart';

class LoginService {
  final _repository = LoginRepository();

  Future<AuthTokenModel> attemptLogin(String email, String password) {
    return _repository.attemptLogin(email, password);
  }
}

class NetworkError extends Error {}
