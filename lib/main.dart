import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2cli/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Firebase Firestore CRUD')),
        body: CRUDExample(),
      ),
    );
  }
}
class CRUDExample extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(String userId, String name, String email) {
    return firestore.collection('users').doc(userId).set({
      'name': name,
      'email': email,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getUser(String userId) async {
    DocumentSnapshot document = await firestore.collection('users').doc(userId).get();
    if (document.exists) {
      print("User data: ${document.data()}");
    } else {
      print("No such user!");
    }
  }

  Future<void> updateUser(String userId, String name) {
    return firestore.collection('users').doc(userId).update({
      'name': name,
    }).then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String userId) {
    return firestore.collection('users').doc(userId).delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => addUser('1', 'John Doe', 'john@example.com'),
            child: Text('Add User'),
          ),
          ElevatedButton(
            onPressed: () => getUser('1'),
            child: Text('Get User'),
          ),
          ElevatedButton(
            onPressed: () => updateUser('1', 'Jane Doe'),
            child: Text('Update User'),
          ),
          ElevatedButton(
            onPressed: () => deleteUser('1'),
            child: Text('Delete User'),
          ),
        ],
      ),
    );
  }
}


