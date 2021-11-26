import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';

class BottomModalSheetAddPass extends StatefulWidget {
  const BottomModalSheetAddPass({Key? key}) : super(key: key);

  @override
  _BottomModalSheetAddPassState createState() =>
      _BottomModalSheetAddPassState();
}

class _BottomModalSheetAddPassState extends State<BottomModalSheetAddPass> {
    TextEditingController appNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _appnameEnabled = true;
    bool _usernameEnabled = true;
    bool _passwordEnabled = true;
    bool _addButtonEnabled = true;
    bool _showPasswordEnabled = true;
    final formGlobalKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Future  _validateAddPass() async
    {
      if(formGlobalKey.currentState!.validate()==true)
      {
        await Network.addpass(userNameController.text.trim(), passwordController.text.trim(), appNameController.text.trim(), context).whenComplete((){
          Navigator.pop(context);
        });
      }
    }
    return SingleChildScrollView(
      child: Form(
        key: formGlobalKey,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: height * 0.60,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      "ADD PASSWORD",
                      style: TextStyle(
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF747474)),
                    ),
                  ),
                  TextFormField(
                    enabled: _appnameEnabled,
                    controller: appNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.android_outlined),
                      hintText: "APP NAME",
                      hintStyle: TextStyle(fontSize: height * 0.025),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (valUsername) {
                      if (valUsername!.isEmpty) {
                        return "APP NAME CANNOT BE EMPTY";
                      } else {
                        return null;
                      }
                    },
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
                  _addButtonEnabled
                      ? ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _usernameEnabled = false;
                              _passwordEnabled = false;
                              _addButtonEnabled = false;
                            });
                            await _validateAddPass();
                            setState(() {
                              _usernameEnabled = true;
                              _passwordEnabled = true;
                              _addButtonEnabled = true;
                            });
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: height * 0.025),
                          ),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                                Size(width, height * 0.085)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffe4717d)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: height * 0.025),
                          ),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                                Size(width, height * 0.085)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
          ),
        ),
      ),
    );
  }
}
