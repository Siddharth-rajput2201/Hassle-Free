import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';

class BottomModalSheetEdit extends StatefulWidget {
  
  final String appname;
  final String passwordId;
  const BottomModalSheetEdit({ Key? key ,required this.appname,required this.passwordId}) : super(key: key);

  @override
  _BottomModalSheetEditState createState() => _BottomModalSheetEditState();
}

class _BottomModalSheetEditState extends State<BottomModalSheetEdit> {
    bool _appnameEnabled = true;
    bool _usernameEnabled = true;
    bool _passwordEnabled = true;
    bool _addButtonEnabled = true;
    bool _showPasswordEnabled = true;
    final formGlobalKey = GlobalKey<FormState>();
    TextEditingController appNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future  _validateUpdate(String passwordid) async
    {
      if(formGlobalKey.currentState!.validate()==true)
      {
          if(appNameController.text.isEmpty && userNameController.text.isEmpty && passwordController.text.isEmpty)
          {
            customSnackBar(context, "ALL FIELD'S CANNOT BE EMPTY", Colors.red);
            Navigator.pop(context);
          }
         
          if(userNameController.text.isEmpty && passwordController.text.isEmpty && appNameController.text.isNotEmpty)
          {
            if(await Network.updateappname(passwordid, appNameController.text, context))
            {
               customSnackBar(context, "UPDATED APPNAME SUCCESSFULLY", Colors.green);
               Navigator.pop(context);
            }
           
          }
          if(appNameController.text.isNotEmpty && userNameController.text.isNotEmpty && passwordController.text.isEmpty)
          {
            if(await Network.updateappname(passwordid, appNameController.text, context) && await Network.updateappusername(passwordid, userNameController.text, context))
            {
              customSnackBar(context, "UPDATED APPNAME & USERNAME SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
          }
           if(appNameController.text.isNotEmpty && userNameController.text.isNotEmpty && passwordController.text.isNotEmpty)
          {
            if(await Network.updateappname(passwordid, appNameController.text, context) && await Network.updateappusername(passwordid, userNameController.text, context) && await Network.updatepassword(passwordid, passwordController.text, context))
            {
              customSnackBar(context, "UPDATED APPNAME , USERNAME & PASSWORD SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
           
          }
          if(appNameController.text.isEmpty && userNameController.text.isNotEmpty && passwordController.text.isEmpty)
          {
            if(await Network.updateappusername(passwordid, userNameController.text, context))
            {
              customSnackBar(context, "UPDATED USERNAME SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
          }
          if(appNameController.text.isEmpty && userNameController.text.isNotEmpty && passwordController.text.isNotEmpty)
          {
            if(await Network.updateappusername(passwordid, userNameController.text, context) && await Network.updatepassword(passwordid, passwordController.text, context))
            {
              customSnackBar(context, "UPDATED USERNAME & PASSWORD SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
          }
           if(appNameController.text.isNotEmpty && userNameController.text.isEmpty&& passwordController.text.isNotEmpty)
          {
            if(await Network.updateappname(passwordid, appNameController.text, context) && await Network.updatepassword(passwordid, passwordController.text, context))
            {
              customSnackBar(context, "UPDATED APPNAME & PASSWORD SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
          }
           if(appNameController.text.isEmpty && userNameController.text.isEmpty&& passwordController.text.isNotEmpty)
          {
            if(await Network.updatepassword(passwordid, passwordController.text, context))
            {
              customSnackBar(context, "UPDATED PASSWORD SUCCESSFULLY", Colors.green);
              Navigator.pop(context);
            }
          }
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
                      "UPDATE ${widget.appname}",
                      style: TextStyle(
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF747474)),
                    ),
                  ),
                  TextFormField(
                    // initialValue: widget.appname,
                    enabled: _appnameEnabled,
                    controller: appNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.android_outlined),
                      hintText: "UPDATE APP NAME",
                      hintStyle: TextStyle(fontSize: height * 0.025),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    // validator: (valUsername) {
                    //   if (valUsername!.isEmpty) {
                    //     return "APP NAME CANNOT BE EMPTY";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  TextFormField(
                    // initialValue: widget.username,
                    enabled: _usernameEnabled,
                    controller: userNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      hintText: "UPDATE USERNAME",
                      hintStyle: TextStyle(fontSize: height * 0.025),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    // validator: (valUsername) {
                    //   if (valUsername!.isEmpty) {
                    //     return "USERNAME CANNOT BE EMPTY";
                    //   } else {
                    //     // setState(() {
                    //     //   _loginButtonEnabled = true;
                    //     // });
                    //     return null;
                    //   }
                    // },
                  ),
                  TextFormField(
                    // initialValue: widget.password,
                    enabled: _passwordEnabled,
                    controller: passwordController,
                    obscureText: _showPasswordEnabled,
                    decoration: InputDecoration(
                      hintText: "UPDATE PASSWORD",
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
                    // validator: (valPassword) {
                    //   if (valPassword!.isEmpty) {
                    //     return "PASSWORD CANNOT BE EMPTY";
                    //   } else {
                    //     // setState(() {
                    //     //   _loginButtonEnabled = true;
                    //     // });
                    //     return null;
                    //   }
                    // },
                  ),
                  _addButtonEnabled
                      ? ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _appnameEnabled = false;
                              _usernameEnabled = false;
                              _passwordEnabled = false;
                              _addButtonEnabled = false;
                            });
                            await _validateUpdate(widget.passwordId);
                            setState(() {
                              _appnameEnabled = true;
                              _usernameEnabled = true;
                              _passwordEnabled = true;
                              _addButtonEnabled = true;
                            });
                          },
                          child: Text(
                            "UPDATE",
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
                            "UPDATE",
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
                        Text("NOTE* : Leave empty if you do not want to update that field",style: TextStyle(color: Colors.grey),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}