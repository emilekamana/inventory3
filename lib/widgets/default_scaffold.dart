import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/auth_controller.dart';

final AuthController _auth = AuthController();

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? floatingButton;
  final PreferredSizeWidget? bottom;
  final bool? scrollable;

  const DefaultScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.floatingButton,
      this.bottom,
      scrollable})
      : scrollable = scrollable ?? true;
// await _auth.signOut().catchError((e) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(e.message),
//                     ));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: bottom,
          actions: [
            PopupMenuButton<int>(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              iconSize: 30,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.red,
                      ),
                      Text(
                        'Log out',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  await _auth.signOut().then((value) {
                    if (_auth.currentUser == null) {
                      Navigator.of(context).popAndPushNamed('/login');
                    }
                  });
                }
              },
            )
          ],
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/');
                },
                icon: const Icon(Icons.home),
                iconSize: 24,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        // drawer:
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: scrollable! ? SingleChildScrollView(child: body) : body,
        ),
        floatingActionButton: floatingButton,
      ),
    );
  }

  buildDrawer(BuildContext context) {
    return Drawer(
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
                Navigator.of(context).popAndPushNamed('/stock');
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
                Navigator.of(context).popAndPushNamed('/history');
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
    );
  }
}
