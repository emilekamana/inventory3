import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingButton;

  const DefaultScaffold({super.key, required this.title, required this.body, this.floatingButton});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text(
                    'Stock',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    'History',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
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
