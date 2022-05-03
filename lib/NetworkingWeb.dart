import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Api.dart';
import 'package:hassle_free/screens/Home.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:http/http.dart' as Http;
// import 'package:shared_preferences/shared_preferences.dart';


class NetworkWeb {
  static Future<void> authweb(BuildContext context) async {
    var url = Uri.parse(Api.auth);
    String token = await Storage.getToken();
    Map body = {
      'JWT_TOKEN': token,
    };
    try {
      final response = await Http.post(url, body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['message'] == "AUTHENTICATED") {
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
      } else {
        if (data['message'] == "UNAUTHORIZED") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
        if (data['message'] == "MISSING TOKEN") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } 
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.red);
      log(error.toString());
    }
  }
}