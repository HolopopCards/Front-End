import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/storage/user.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  /// Save user to storage.
  Future<bool> saveUserAsync(User user) async {
    final prefs = await SharedPreferences.getInstance();

    Logger('user preferences').fine("Saving user to storage: $user");
    await prefs.setString("email", user.username);
    await prefs.setString("token", user.token);
    await prefs.setString("refreshtoken", user.refreshToken);

    return true;
  }


  /// Update access token in storage.
  Future<Result> updateToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    Logger('user preferences').fine("Updating access token: $token");
    await prefs.setString("token", token);
    return Result.fromSuccess(null);
  }


  /// Get user from storage.
  Future<User?> getUserAsync() async {
    Logger('user preferences').fine("Getting user for login or not...");
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    final refreshToken = prefs.getString("refreshtoken");
    Logger('user preferences').fine("Getting tokens from storage: tk: $token | rtk: $refreshToken");
    if (token == null || refreshToken == null) {
      return null;
    }

    final email = prefs.getString("email")!;

    final user = User(username: email, token: token, refreshToken: refreshToken);
    Logger('user preferences').fine("User retrieved from storage: $user");
    return user;
  }


  /// Remove user from storage.
  void removeUser() async {
    final prefs = await SharedPreferences.getInstance();

    Logger('user preferences').fine("Removing user from storage...");

    prefs.remove("email");
    prefs.remove("token");
    prefs.remove("refreshtoken");
  }


  /// Get token from user in storage.
  Future<String?> getAccessTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    Logger('user preferences').info("Getting access token from storage: $token");
    return token;
  }

  /// Get refresh token from user in storage.
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refreshtoken");
    Logger('user preferences').info("Getting refresh token from storage: $refreshToken");
    return refreshToken;
  }
}