import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Api.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  static Future<bool> login(
      String username, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(Api.login);
    Map body = {'USER_NAME': username, 'USER_PASSWORD': password};
    try {
      final response = await Http.post(url, body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['token'].toString().isNotEmpty) {
        //Storage.storeToken(data['token']);
        await prefs.setString("token", data['token']);
        await prefs.setString("username", username);
        await prefs.setString("password", password);
        //Storage.storeUsername(username);
        //Storage.storePassword(password);
        return true;
      } else {
        if (data['message'] == "USER DOES NOT EXIST") {
          customSnackBar(
              context, "USER DOES DO NOT EXISTS.TRY SIGNING UP", Colors.red);
          return false;
        }
        if (data['message'] == "INVALID CREDENTIALS") {
          customSnackBar(
              context, "EITHER USERNAME OR PASSWORD IS INCORRECT", Colors.red);
          return false;
        } else {
          log(response.body);
          customSnackBar(context, "ERROR", Colors.red);
          return false;
        }
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.red);
      log(error.toString());
      return false;
    }
  }

  static Future<bool> register(
      String username, String password, BuildContext context) async {
    var url = Uri.parse(Api.register);
    Map body = {'USER_NAME': username, 'USER_PASSWORD': password};
    try {
      final response = await Http.post(url, body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200 &&
          data['message'] == "REGISTERED SUCCESSFULLY") {
        customSnackBar(
            context, "REGISTERED SUCCESSFULLY. KINDLY LOGIN", Colors.green);
        return true;
      } else {
        if (data['message'] == "USER ALREADY REGISTERED") {
          customSnackBar(context, "USERNAME ALREADY TAKEN", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD LENGTH TOO SHORT") {
          customSnackBar(context, "PASSWORD LENGTH TOO SHORT", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD LENGTH TOO LONG") {
          customSnackBar(context, "PASSWORD LENGTH TOO LONG", Colors.red);
          return false;
        } else {
          log(response.body);
          customSnackBar(context, "ERROR", Colors.red);
          return false;
        }
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.red);
      log(error.toString());
      return false;
    }
  }

  static Future<List<Pass>> retrieve(BuildContext context) async {
    var url = Uri.parse(Api.retrieve);
    String token = await Storage.getToken();
    Map body = {'JWT_TOKEN': token};
    try {
      final response = await Http.post(url, body: body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        log(data.toString());
        return data.map((e) => Pass.fromJson(e)).toList();
      } else {
        log(response.body);
        customSnackBar(context, "ERROR", Colors.red);
        return [];
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.black);
      log(error.toString());
      return [];
    }
  }
}
