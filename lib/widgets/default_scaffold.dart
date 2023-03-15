import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/repositories/auth_repository.dart';

final AuthRepository _auth = AuthRepository();

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingButton;

  const DefaultScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.floatingButton});
// await _auth.signOut().catchError((e) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(e.message),
//                     ));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await _auth.signOut().then((value) {
                  Navigator.of(context).popAndPushNamed('/signin');
                }).catchError((e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.message),
                  ));
                });
              },
              icon: const Icon(Icons.exit_to_app),
            )
            // CircleAvatar(
            //   backgroundColor: Colors.white,
            //   child: Icon(
            //     Icons.person,
            //     color: Colors.blue,
            //   ),
            // ),
          ],
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
            padding: const EdgeInsets.all(0),
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/');
                  },
                  leading: const Icon(Icons.home),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/view_stock');
                  },
                  title: const Text(
                    'Stock',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.note),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/notes');
                  },
                  title: const Text(
                    'Notes',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/');
                  },
                  leading: const Icon(Icons.history),
                  title: const Text(
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
