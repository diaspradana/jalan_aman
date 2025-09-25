import '../models/user_model.dart';

class AuthController {
  static UserModel? login(String username, String password) {
    if (username == "admin" && password == "123") {
      return UserModel(username: username, role: "admin");
    } else if (username == "petugas" && password == "123") {
      return UserModel(username: username, role: "petugas");
    } else {
      return null;
    }
  }
}
