import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:stock_management/controllers/auth_controller.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

final AuthController _auth = AuthController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: const Text(
            'Inventory',
            style: TextStyle(
              color: Color(0xFF4796BD),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          backgroundColor: const Color(0xFFF3F9FB),
          actions: [
            PopupMenuButton<int>(
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF4796BD),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            children: const [
              HomeMenuButton(
                text: 'Sales',
                buttonIcon: Icons.monetization_on_outlined,
                path: '/sales',
              ),
              HomeMenuButton(
                text: 'Stock',
                buttonIcon: Icons.list_alt,
                path: '/stock',
              ),
              HomeMenuButton(
                text: 'History',
                buttonIcon: Icons.history,
                path: '/history',
              ),
              HomeMenuButton(
                text: 'Notes',
                buttonIcon: Icons.history,
                path: '/notes',
              ),
            ],
          ),
        ),
        floatingActionButton: const HomeFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(onTap: (){
          Navigator.of(context).pushNamed('/add_sale');
        },label: 'New sale', child: const Icon(Icons.monetization_on)),
        SpeedDialChild(onTap: ()=> 
          Navigator.of(context).pushNamed('/add_Stock'),label: 'New stock item', child: const Icon(Icons.list)),
        SpeedDialChild(onTap: ()=> 
          Navigator.of(context).pushNamed('/notes'),label: 'New note', child: const Icon(Icons.note_add)),
      ],
    );
  }
}

class HomeMenuButton extends StatelessWidget {
  final String text;
  final IconData buttonIcon;
  final String path;
  const HomeMenuButton(
      {super.key,
      required this.text,
      required this.buttonIcon,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4796BD).withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFDFEFF),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              buttonIcon,
              color: const Color(0xFF4796BD),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF495D69),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(path);
        },
      ),
    );
  }
}
