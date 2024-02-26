import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String refreshTokenKey = 'refreshToken';
  static const String accessTokenKey = 'accessToken';

  static Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
  }

  static Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey) ?? "";
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey) ?? "";
  }

  static Future<void> saveIsLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  Future<void> saveCurrentUser(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  getCurrentSavedUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      return json.decode(jsonString);
    } else {
      return null;
    }
  }

  deleteCurrentSavedUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
