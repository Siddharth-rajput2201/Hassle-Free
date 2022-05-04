import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screensweb/LoginWeb.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogBoxDeleteAcc extends StatefulWidget {
  const DialogBoxDeleteAcc({ Key? key }) : super(key: key);

  @override
  State<DialogBoxDeleteAcc> createState() => _DialogBoxDeleteAccState();
}

class _DialogBoxDeleteAccState extends State<DialogBoxDeleteAcc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.27,
      width: width * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Material(
                      borderRadius: BorderRadius.circular(30),
                            color: ThemeColors.kBackGroundColor,
                    child: InkWell(
                       highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              onTap: (){
                                Navigator.pop(context);
                              },
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
            Center(
              child: Text(
                "You will be Logged Out of your account",
                style: TextStyle(
                    fontSize: height * 0.035,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF747474)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () async{
                    await Network.deleteacc(context);
                    SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear(); 
                     Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginWeb()),
                    (Route<dynamic> route) => false
                  );
                  },
                  child: Text(
                    "Delete this account",
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: ThemeColors.kDeleteColor, width: 2)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(width * 0.3, height * 0.085)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffe4717d)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        // side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}