import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class DialogBoxDelete extends StatefulWidget {
  final String appName;
  final String passwordId;
  const DialogBoxDelete(
      {required this.appName, required this.passwordId, Key? key})
      : super(key: key);

  @override
  State<DialogBoxDelete> createState() => _DialogBoxDeleteState();
}

class _DialogBoxDeleteState extends State<DialogBoxDelete> {
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
      width: width * 0.4,
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
                  child: Text(
                    "NO",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.blue, width: 2)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(width * 0.1, height * 0.085)),
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
                    ? Container(
                        // duration: Duration(milliseconds: 500),
                        height: height * 0.085,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                          color: ThemeColors.kBackGroundColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: ThemeColors.kTextColor, width: 0.3),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.kDarkShadowColor,
                              offset: Offset(4, 4),
                              blurRadius: 7,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: ThemeColors.kLightShadowColor,
                              offset: Offset(-4, -4),
                              blurRadius: 7,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          color: ThemeColors.kBackGroundColor,
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                _deleteButtonEnabled = false;
                              });
                              await _validateDeletePass(widget.passwordId);
                              setState(() {
                                _deleteButtonEnabled = true;
                              });
                            },
                            
                            child: Center(
                                child: Text(
                              "DELETE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.025,
                                  color: ThemeColors.kTextColor),
                            )),
                          ),
                        ),
                      )
                    : Container(
                        // duration: Duration(milliseconds: 500),
                        height: height * 0.085,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                          color: ThemeColors.kBackGroundColor,
                          border: Border.all(
                              color: ThemeColors.kTextColor, width: 0.3),
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              ThemeColors.kLinearFirstGradient,
                              ThemeColors.kLinearSecondGradient,
                              // Color(0xFFf7f5ec)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.4],
                            tileMode: TileMode.clamp,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.kDarkShadowColor,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: ThemeColors.kLightShadowColor,
                              offset: Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "DELETE",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.025,
                              color: Colors.blue,
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
