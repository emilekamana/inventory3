import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository{
    final userCollection = FirebaseFirestore.instance.collection('users');  
}