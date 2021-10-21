import 'package:cloud_firestore/cloud_firestore.dart';

/// Todo model to map data properly.

class Todo{
  String title;
  String priority;
  String id;

  Todo({
    required this.id,
    required this.title,
    required this.priority
  });


  // the data refers to the data from Firestore.
  // mapping == dictionary from python.
  static Todo fromSnapshot(DocumentSnapshot data){
    Todo todo = Todo(title: data["title"], priority: data["priority"], id: data["id"]);
    return todo;
  }
}