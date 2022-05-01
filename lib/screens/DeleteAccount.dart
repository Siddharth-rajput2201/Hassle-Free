import 'package:flutter/material.dart';
import 'package:hassle_free/utils/BottomModalSheetDelAcc.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class DeleteAccount extends StatefulWidget {
  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  bool _continueButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeColors.kTextColor),
        title: Text(
          "Delete Account",
          style: TextStyle(color: ThemeColors.kTextColor),
        ),
        elevation: 0.0,
        backgroundColor: ThemeColors.kBackGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Once you delete this account.There is no going back.All the data associated with this account and this account will deleted permanently.",
                style: TextStyle(fontSize: height * 0.028),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              FutureBuilder<Object>(
                  future: Storage.getUserName(),
                  builder: (context, snapshot) {
                    return RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Please type ',
                            style: TextStyle(
                                fontSize: height * 0.028, color: Colors.black),
                          ),
                          TextSpan(
                            text: '"',
                            style: TextStyle(
                                fontSize: height * 0.028, color: Colors.black),
                          ),
                          TextSpan(
                            text: snapshot.data.toString(),
                            style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: '"',
                            style: TextStyle(
                                fontSize: height * 0.028, color: Colors.black),
                          ),
                          TextSpan(
                            text: ' to confirm.',
                            style: TextStyle(
                                fontSize: height * 0.028, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              Form(
                key: formGlobalKey,
                child: Container(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ThemeColors.kLinearFirstGradient,
                        ThemeColors.kLinearSecondGradient,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.4],
                      tileMode: TileMode.clamp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  child: TextFormField(
                    enabled: true,
                    controller: userNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColors.kBackGroundColor),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColors.kBackGroundColor),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: "USERNAME",
                      hintStyle: TextStyle(fontSize: height * 0.025),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (valUsername) async {
                      if (valUsername == await Storage.getUserName()) {
                        setState(() {
                          _continueButtonEnabled = true;
                        });
                      } else {
                        setState(() {
                          _continueButtonEnabled = false;
                        });
                      }
                    },
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
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              OutlinedButton(
                style: ButtonStyle(
                      side: _continueButtonEnabled ? MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.red, width: 2)) : MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.grey[400]!, width: 2)),
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size(width, height * 0.085)),
                      foregroundColor:
                           _continueButtonEnabled ? MaterialStateProperty.all<Color>(Color(0xffe4717d)) : MaterialStateProperty.all<Color>(Colors.grey[400]!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          // side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                onPressed: _continueButtonEnabled ? (){
                  showModalBottomSheet(
                      backgroundColor: ThemeColors.kBackGroundColor,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      context: context,
                      builder: (context) {
                        return BottomModalSheetDelAcc();
                      });
                } : null,
                child: Text("Continue",style: TextStyle(fontSize: height * 0.025)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
