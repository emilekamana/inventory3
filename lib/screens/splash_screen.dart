import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:stock_management/main.dart';

import '../controllers/auth_controller.dart';

final AuthController _auth = AuthController();

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _SlashState();
}

class _SlashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        (() => {
              if (_auth.currentUser != null)
                {Navigator.of(context).popAndPushNamed('/')}
              else
                Navigator.of(context).popAndPushNamed('/login')
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('images/logo.svg'),
            const Text(
              'Inventory',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
