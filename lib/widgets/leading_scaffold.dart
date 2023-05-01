import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/auth_controller.dart';

final AuthController _auth = AuthController();

class LeadingScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingButton;

  const LeadingScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.floatingButton});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: body,
        ),
        floatingActionButton: floatingButton,
      ),
    );
  }
}
