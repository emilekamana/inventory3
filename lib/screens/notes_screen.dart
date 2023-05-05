import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/note_controller.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotesScreenState();
  }
}

NoteController _noteController = NoteController();

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference<Map<String, dynamic>> _notes =
      _noteController.notesCollection;

  List notes = [];

  @override
  void initState() {
    notes.add('Some message');
    notes.add('Some message');
    notes.add('Some message');
    super.initState();
  }

  deleteNote(id) async {
    await _noteController.notesCollection.doc(id).delete();
  }

  clearNotes() {
    // deleting all notes and changing state
    setState(() {
      notes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Notes",
      floatingButton: FloatingActionButton(
        // Button to open dialog box and create new note
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // alert dialog for the inputs
                  // backgroundColor: const Color.fromARGB(255, 248, 221, 125),
                  title: const Text(
                    'New note',
                    style: TextStyle(color: Colors.blue),
                  ),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                  content: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Write here',
                    ),
                  ),
                  actions: [
                    SizedBox(
                      // sized box to determine size of child
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () async {
                            if (_controller.text.isNotEmpty) {
                              await _noteController
                                  .createNote(_controller.text);
                            } else {
                              showErrorSnackbar(
                                  "Error: Can't create an Empty note");
                            }
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'Create note',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 18),
                          )),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          // Icon
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: StreamBuilder(
          stream: _notes.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4796BD))),
                    // Loader Animation Widget
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                  ],
                ),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Column(
                children: const <Widget>[
                  Center(child: Text("Unable to find any records"))
                ],
              );
            }
            if (snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String note =
                        snapshot.data!.docs[index]['text'] ?? 'Empty Note';
                    return Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          tileColor: Colors.blueGrey.shade100,
                          title: Text(note),
                          trailing: PopUpOptionMenu(
                            deleteNote:
                                deleteNote,
                            id: snapshot.data!.docs[index].id,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              );
            }

            return const Center(child: Text('Something went wrong!!'));
          }),
    );
  }

  void showErrorSnackbar(error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        content: Text('Error: $error')));
  }
}

enum MenuOptions { Delete, Edit }

class PopUpOptionMenu extends StatelessWidget {
  // pop up menu for the cards
  final id;
  final deleteNote;
  const PopUpOptionMenu({super.key, this.deleteNote, this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<MenuOptions>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<MenuOptions>>[
          // Options for the menu
          PopupMenuItem(
            value: MenuOptions.Delete,
            child: FittedBox(
                child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text('Delete'),
                ),
              ],
            )),
          ),
        ];
      },
      onSelected: (value) {
        // set actions for the menu
        switch (value) {
          case MenuOptions.Delete:
            deleteNote(id);
            break;
          case MenuOptions.Edit:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }
}
