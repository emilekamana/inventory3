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

class _SlashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );
    Timer(
      const Duration(seconds: 12),
      () {
        if (_auth.currentUser != null) {
          Navigator.of(context).popAndPushNamed('/');
        } else {
          Navigator.of(context).popAndPushNamed('/login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Inventory',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}