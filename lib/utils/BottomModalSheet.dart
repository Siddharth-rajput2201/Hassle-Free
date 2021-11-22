import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';

class BottomModalSheet extends StatefulWidget {
  final String encryptedPassword;
  final String username;
  final Color color;
  const BottomModalSheet(
      {Key? key, required this.encryptedPassword, required this.username ,required this.color})
      : super(key: key);

  @override
  _BottomModalSheetState createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: FutureBuilder(
        future: Network.decrypt(widget.encryptedPassword, context),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              child: Column(
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.040,
                    ),
                  ),
                  Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.040,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [CircularProgressIndicator()],
            );
          }
        },
      ),
    );
  }
}
