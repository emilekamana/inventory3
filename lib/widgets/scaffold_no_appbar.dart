import 'package:flutter/material.dart';

class ScaffoldNoAppBar extends StatelessWidget {
  final Widget body;
  final Widget? floatingButton;

  const ScaffoldNoAppBar({super.key, required this.body, this.floatingButton});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40, 0),
            child: SingleChildScrollView(child: body),
          ),
        ),
        floatingActionButton: floatingButton,
      ),
    );
  }
}
