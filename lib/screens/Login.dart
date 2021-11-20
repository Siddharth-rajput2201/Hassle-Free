import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hassle_free/screens/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: SizedBox(
            height: height * 0.935,
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          hintText: "USERNAME",
                          hintStyle: TextStyle(fontSize: height * 0.025),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(fontSize: height * 0.025),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(width, height * 0.085)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffe4717d)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
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
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register())),
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
    );
  }
}
