import 'package:holopop/shared/storage/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  /// Save user to storage.
  Future<bool> saveUserAsync(User user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", user.username);
    await prefs.setString("token", user.token);

    return true;
  }


  /// Get user from storage.
  Future<User?> getUserAsync() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    if (token == null) {
      return null;
    }

    final email = prefs.getString("email")!;

    return User(username: email, token: token);
  }


  /// Remove user from storage.
  void removeUser() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("email");
    prefs.remove("token");
  }


  /// Get token from user in storage.
  Future<String?> getTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return token;
  }
}