import 'package:mylife/models/auth/user.dart';
import 'package:mylife/service/auth/user/user_repository.dart';

class UserService {
  final _repository = UserRepository();

  Future<UserModel> getAuthUser() {
    return _repository.getAuthUser();
  }

  Future<UserModel> registerUser(UserModel model) {
    return _repository.registerUser(model);
  }
}

class NetworkError extends Error {}
