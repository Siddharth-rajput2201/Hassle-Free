import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomModalSheetDelAcc extends StatefulWidget {
  const BottomModalSheetDelAcc({ Key? key }) : super(key: key);

  @override
  State<BottomModalSheetDelAcc> createState() => _BottomModalSheetDelAccState();
}

class _BottomModalSheetDelAccState extends State<BottomModalSheetDelAcc> {
  @override
Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "You will be Logged Out of your account",
              style: TextStyle(
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF747474)),
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
                     Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                  },
                  child: Text(
                    "Delete this account",
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: ThemeColors.kDeleteColor, width: 2)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(width * 0.91, height * 0.085)),
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
