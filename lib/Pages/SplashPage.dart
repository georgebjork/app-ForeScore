import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Components/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer? recoverSessionTimer;

  @override
  void initState() {
    super.initState();

      

    //  const _duration = Duration(seconds: 2);
    //   recoverSessionTimer = Timer(_duration, () {
    //   recoverSupabaseSession();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: HexColor("#89A057"), strokeWidth: 6.0,)),
    );
  }
}