import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static void storeToken(String tokenValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", tokenValue);
  }

  static void storeUsername(String usernameValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", usernameValue);
  }

  static void storePassword(String passwordValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", passwordValue);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    return token;
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username").toString();
    return username;
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString("password").toString();
    return password;
  }
}
