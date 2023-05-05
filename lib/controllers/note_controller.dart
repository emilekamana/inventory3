import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

class NoteController {
  CollectionReference<Map<String, dynamic>> get notesCollection =>
      FirebaseFirestore.instance.collection('notes');

  Future createNote(String text) async {
    await notesCollection.add({'text': text});
  }

  Future updateNote(String id, String text) async {
    await notesCollection.doc(id).update({'text': text});
  }
}
