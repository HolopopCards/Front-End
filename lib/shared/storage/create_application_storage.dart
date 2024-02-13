import 'dart:convert';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateApplicationStorage {
  Future<bool> saveAppAsync(CreateApplication application) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('create_application', jsonEncode(application));
    return true;
  }


  Future<CreateApplication?> getAppAsync() async {
    final prefs = await SharedPreferences.getInstance();

    final appString = prefs.getString('create_application');
    if (appString == null) {
      return null;
    }
    final appJson = jsonDecode(appString);

    return CreateApplication.fromJson(appJson);
  }
}