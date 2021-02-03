import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';


class Preferences {
  static Future<bool> savePhoneNumber(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.phoneNmberKey, token);
  }

  static Future<String> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.phoneNmberKey);
  }

  static Future<bool> saveUserId(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.userIdKey, token);
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.userIdKey);
  }


  static Future<bool> clearPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.remove(Constants.userIdKey);
    prefs.remove(Constants.phoneNmberKey);
    return true;
  }
}
