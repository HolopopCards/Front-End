import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:holopop/shared/firebase/firebase_utlity.dart';
import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/storage/user.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:holopop/shared/config/appsettings.dart';


enum LoginStatus { 
  notLoggedIn,
  authenticating,
  loggedIn,
  loggedOut
}


class AuthProvider with ChangeNotifier {
  LoginStatus _loggedInStatus = LoginStatus.notLoggedIn;

  LoginStatus get loggedInStatus => _loggedInStatus;

  // TODO: put in file
  final publicKey = """
-----BEGIN PUBLIC KEY-----
MIIBITANBgkqhkiG9w0BAQEFAAOCAQ4AMIIBCQKCAQBos3dwegC8x5bv8QiJp86l
rbUaP4T9k0hJV89b2brfGRptQ/em8gi1hMPbzZ+gxgWDlX03MzAGrEHs1xWFGrPO
Vod3y1ROPObXsC+c7WtaAOn3TMTghYSUCPvXEkXPwQQgdUVMV3OeonxIYmnxF6bC
vfkfDSd5ebGoOyt0CkcFvtLm8hINK66/yJpbc/K8b1ooexvURkK+hu2m+o54lcer
VCiefWLTHIb9MO9BwbxEACrFHSmD93GwEplURdGnjJIi6V1bdpRXe1ZAg58ldHn8
cJivC5EYdGy0cbbh0/DG2d5KfhqqTeCvJeq1nne9g/R2RCzPtWbPDUXBjtTJYsvT
AgMBAAE=
-----END PUBLIC KEY-----""";


  Future<Result<User>> login(String email, String password) async { 
    _loggedInStatus = LoginStatus.authenticating;
    notifyListeners();

    final encryptedAndEncodedPassword = encryptAndEncode(password);
    final token = await FirebaseUtility().getFcmToken();

    final response = await post(
      Uri.parse("${AppSettings().getApiHost()}/login"),
      body: json.encode({
        'username': email,
        'password': encryptedAndEncodedPassword,
        'fcmtoken': token
        }),
      headers: {'Content-Type': 'application/json' }
    ).timeout(const Duration(seconds: 5), onTimeout: () { return Response('Timeout', 408); });

    if (response.statusCode == 408) {
      return Result.fromFailure("Timeout");
    }

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      final token = data['token'];
      final user = User(username: email, token: token);

      await UserPreferences().saveUserAsync(user);
      _loggedInStatus = LoginStatus.loggedIn;
      notifyListeners();
      return Result.fromSuccess(user);
    } else {
      final error = data['error'];
      return Result.fromFailure(error);
    }
  }


  Future<Result<User>> register(String name, String phone, DateTime dob, String email, String password) async {
    final encPass = encryptAndEncode(password);
    final token = await FirebaseUtility().getFcmToken();

    try {
      Logger('Auth Provider').info("Registering...");
      final response = await post(
        Uri.parse("${AppSettings().getApiHost()}/register"),
        body: json.encode({
          'name': name,
          'phone': phone,
          'dob': dob.toIso8601String(),
          'email': email,
          'password': encPass,
          'fcmtoken': token
        }),
        headers: { 'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5), onTimeout: () { return Response('Timeout', 408); });

      if (response.statusCode == 408) {
        return Result.fromFailure("Timeout");
      }

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final token = data['token'];
        final user = User(username: email, token: token);

        await UserPreferences().saveUserAsync(user);
        _loggedInStatus = LoginStatus.loggedIn;
        notifyListeners();
        return Result.fromSuccess(user);
      } else {
        final error = data['error'];
        return Result.fromFailure(error);
      }
    } catch (e) {
      return Result.fromFailure(e.toString());
    }
  }


  // TODO: Put somewhere better.
  String encryptAndEncode(String password) {
    final parser    = RSAKeyParser();
    final pk        = parser.parse(publicKey) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: pk));
    final encrypted = encrypter.encrypt(password);
    return encrypted.base64;
  }
}