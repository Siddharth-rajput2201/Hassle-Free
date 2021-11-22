import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/UserPass.dart';
import 'package:hassle_free/screens/Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _usernameEnabled = true;
  bool _passwordEnabled = true;
  bool _signUpButtonEnabled = true;
  bool _showPasswordEnabled = true;
  final formGlobalKey = GlobalKey<FormState>();

  Future _validatelogin() async {
    if (formGlobalKey.currentState!.validate() == true) {
      if (await Network.login(userNameController.text.trim(),
          passwordController.text.trim(), context)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPass()),
        );
      }
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formGlobalKey,
                child: SizedBox(
                  height: height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF747474)),
                              ),
                            ),
                            TextFormField(
                              enabled: _usernameEnabled,
                              controller: userNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                hintText: "USERNAME",
                                hintStyle: TextStyle(fontSize: height * 0.025),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              validator: (valUsername) {
                                if (valUsername!.isEmpty) {
                                  return "USERNAME CANNOT BE EMPTY";
                                } else {
                                  // setState(() {
                                  //   _loginButtonEnabled = true;
                                  // });
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              enabled: _passwordEnabled,
                              controller: passwordController,
                              obscureText: _showPasswordEnabled,
                              decoration: InputDecoration(
                                hintText: "PASSWORD",
                                hintStyle: TextStyle(fontSize: height * 0.025),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  child: Icon(_showPasswordEnabled
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      if (_showPasswordEnabled == true) {
                                        _showPasswordEnabled = false;
                                      } else {
                                        _showPasswordEnabled = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              validator: (valPassword) {
                                if (valPassword!.isEmpty) {
                                  return "PASSWORD CANNOT BE EMPTY";
                                } else {
                                  // setState(() {
                                  //   _loginButtonEnabled = true;
                                  // });
                                  return null;
                                }
                              },
                            ),
                            _signUpButtonEnabled
                                ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _usernameEnabled = false;
                                        _passwordEnabled = false;
                                        _signUpButtonEnabled = false;
                                      });
                                      await _validatelogin();
                                      setState(() {
                                        _usernameEnabled = true;
                                        _passwordEnabled = true;
                                        _signUpButtonEnabled = true;
                                      });
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style:
                                          TextStyle(fontSize: height * 0.025),
                                    ),
                                    style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(width, height * 0.085)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xffe4717d)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          // side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: null,
                                    child: Text(
                                      "LOGIN",
                                      style:
                                          TextStyle(fontSize: height * 0.025),
                                    ),
                                    style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(width, height * 0.085)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          // side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "NOT REGISTERED ?",
                                style: TextStyle(color: Color(0xFF747474))),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()),
                                      ),
                                text: " SIGN UP",
                                style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
