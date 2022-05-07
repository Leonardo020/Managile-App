import 'package:mylife/models/auth/user.dart';
import 'package:mylife/service/auth/user/user_repository.dart';

class UserService {
  final _repository = UserRepository();

  Future<UserModel> getAuthUser() {
    return _repository.getAuthUser();
  }
}

class NetworkError extends Error {}
