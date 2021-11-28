import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';

class BottomModalSheetDelete extends StatefulWidget {
  final String appName;
  final String passwordId;
  BottomModalSheetDelete(
      {Key? key, required this.appName, required this.passwordId})
      : super(key: key);

  @override
  _BottomModalSheetDeleteState createState() => _BottomModalSheetDeleteState();
}

class _BottomModalSheetDeleteState extends State<BottomModalSheetDelete> {
  bool _deleteButtonEnabled = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future _validateDeletePass(String passwordid) async {
      if (await Network.deletepass(passwordid.trim(), context)) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }

    return SizedBox(
      height: height * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Are you sure you want to delete ${widget.appName} password?",
              style: TextStyle(
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF747474)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("NO"),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Color(0xffe4717d))),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(width * 0.4, height * 0.085)),
                    // backgroundColor:
                    //     MaterialStateProperty.all<Color>(Color(0xffe4717d)),
                    // overlayColor: MaterialStateProperty.all<Color>(Color(0xffe4717d)),

                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffe4717d)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        // side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                _deleteButtonEnabled
                    ? ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _deleteButtonEnabled = false;
                          });
                          await _validateDeletePass(widget.passwordId);
                          setState(() {
                            _deleteButtonEnabled = true;
                          });
                        },
                        child: Text("YES"),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(width * 0.4, height * 0.085)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffe4717d)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text("YES"),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(width * 0.4, height * 0.085)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
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
