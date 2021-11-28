import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/screens/UserPass.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _redirect();
    super.initState();
  }

  void _redirect() async
  {
    if(await Network.auth(context))
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserPass()));
    }
    else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/Hassle_Free_Logo_Animate.gif"),  
        ],
      ),),
    );
  }
}