import 'package:flutter/material.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotesScreenState();
  }
}

class _NotesScreenState extends State<NotesScreen> {
  String input = ""; // declare variables for the state

  List notes = [];

  @override
  void initState() {
    notes.add('Some message');
    notes.add('Some message');
    notes.add('Some message');
    super.initState();
  }

  deleteNote(index) {
    // deleting notes and changing state
    setState(() {
      notes.removeAt(index);
    });
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
                      fontWeight: FontWeight.w500, fontSize: 24),
                  content: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Write here',
                    ),
                    onChanged: (value) {
                      input = value;
                    },
                  ),
                  actions: [
                    SizedBox(
                      // sized box to determine size of child
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            setState(() {
                              notes.add(input);
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Create note',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                fontSize: 24),
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
      body: notes.isEmpty // check if list is empty and display message
          ? const Center(
              child: Text(
                "No notes added yet! Add one at the by clicking the + button",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
              ),
            )
          : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                itemCount: notes.length,
                // scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        tileColor: Colors.blueGrey.shade100,
                        title: Row(
                          children: [
                            Text(notes[index]),
                          ],
                        ),
                        trailing: PopUpOptionMenu(
                          deleteNote: deleteNote,
                          index: index,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
          ),
    );
  }
}

enum MenuOptions { Delete, Edit }

class PopUpOptionMenu extends StatelessWidget {
  // pop up menu for the cards
  final index;
  final deleteNote;
  const PopUpOptionMenu({super.key, this.deleteNote, this.index});

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
            deleteNote(index);
            break;
          case MenuOptions.Edit:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }
}
