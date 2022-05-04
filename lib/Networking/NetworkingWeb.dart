import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Api.dart';
import 'package:hassle_free/screens/EmailVerification.dart';
import 'package:hassle_free/screens/Home.dart';
import 'package:hassle_free/screensweb/EmailVerificationRegisterWeb.dart';
import 'package:hassle_free/screensweb/LoginWeb.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';
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
            MaterialPageRoute(builder: (context) => LoginWeb()),
          );
        }
        if (data['message'] == "MISSING TOKEN") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginWeb()),
          );
        } 
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.red);
      log(error.toString());
    }
  }


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
        log(data['token'].toString());
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
        }
        if (data['message'] == "MISSING TOKEN") {
          customSnackBar(context, "TOKEN ERROR", Colors.red);
          return false;
        }
        if (data['message'] == "ACCOUNT NOT VERIFIED") {
          await prefs.setString("username", username);
          await prefs.setString("password", password);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EmailVerification()),
          );
          customSnackBar(context, "ACCOUNT NOT VERIFIED", Colors.red);
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

   static Future<void> resendemail(BuildContext context) async {
    var url = Uri.parse(Api.resendEmail);
    String username = await Storage.getUserName();
    String password = await Storage.getPassword();
    Map body = {
      'USER_NAME': username,
      'USER_PASSWORD': password,
    };
    try {
      final response = await Http.post(url, body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 201 &&
          data['message'] == "EMAIL SUCCESSFULLY SENT") {
        customSnackBar(context, "EMAIL SENT SUCCESSFULLY", Colors.green);
      } else {
        if (data['message'] == "UNAUTHORIZED") {
          customSnackBar(context, "UNAUTHORIZED", Colors.red);
        }
        if (data['message'] == "INVALID CREDENTIALS") {
          customSnackBar(context, "INVALID CREDENTIALS", Colors.red);
        }
        if (data['message'] == "USER DOES NOT EXIST") {
          customSnackBar(context, "NO USER FOUND", Colors.red);
        }
        if (data['message'] == "ACCOUNT ALREADY VERIFIED") {
          customSnackBar(context, "ACCOUNT ALREADY VERIFIED", Colors.green);
        }
        if (data['message'] == "MISSING TOKEN") {
          customSnackBar(context, "TOKEN ERROR", Colors.red);
        } 
      }
    } catch (error) {
      customSnackBar(context, "ERROR", Colors.red);
      log(error.toString());
    }
  }


   static Future<bool> register(String username, String password, String emailid,
      BuildContext context) async {
    var url = Uri.parse(Api.register);
    Map body = {
      'USER_NAME': username,
      'USER_PASSWORD': password,
      'EMAIL_ID': emailid
    };
    try {
      final response = await Http.post(url, body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 201 &&
          data['message'] == "REGISTERED SUCCESSFULLY") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EmailVerificationWebRegister(
                    emailid: emailid,
                  )),
        );
        customSnackBar(context, "EMAIL SENT SUCCESSFULLY", Colors.green);
        return true;
      } else {
        if (data['message'] == "USER ALREADY REGISTERED") {
          customSnackBar(context, "USER ALREADY REGISTERED", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD LENGTH TOO SHORT") {
          customSnackBar(context, "PASSWORD LENGTH TOO SHORT", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD LENGTH TOO LONG") {
          customSnackBar(context, "PASSWORD LENGTH TOO LONG", Colors.red);
          return false;
        }
        if (data['message'] == "MISSING TOKEN") {
          customSnackBar(context, "TOKEN ERROR", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD MUST CONTAIN A DIGIT") {
          customSnackBar(context, "PASSWORD MUST CONTAIN A DIGIT", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD MUST CONTAIN A UPPER CHARACTER") {
          customSnackBar(
              context, "PASSWORD MUST CONTAIN A UPPER CHARACTER", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD MUST CONTAIN A LOWER CHARACTER") {
          customSnackBar(
              context, "PASSWORD MUST CONTAIN A LOWER CHARACTER", Colors.red);
          return false;
        }
        if (data['message'] == "PASSWORD MUST CONTAIN A SPECIAL CHARATER") {
          customSnackBar(
              context, "PASSWORD MUST CONTAIN A SPECIAL CHARATER", Colors.red);
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
}