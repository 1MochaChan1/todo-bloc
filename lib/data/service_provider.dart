import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_blocin/models/todo.dart';

/// Functions that perform
/// CRUD operations on Firebase-Firestore.

class DataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Todo>> getTodos() {
    final CollectionReference _todoList = _firestore.collection("Todos");

    try {
      return _todoList.snapshots().map((snapshots) {
        return snapshots.docs.map((e) => Todo.fromSnapshot(e)).toList();
      });
    } catch (err) {
      throw (err);
    }
  }

  Future<void> putTodos(String title, String? priority) async {
    final ref = _firestore.collection("Todos").doc();

    try {
      await ref.set({'title': title, 'priority': priority, 'id': ref.id});
    } catch (e) {
      throw (e);
    }
    return;
  }

  Future<void> updateTodos(Todo todo) async {
    try {
      _firestore
          .collection("Todos")
          .doc(todo.id)
          .update({"title": todo.title, "priority": todo.priority});
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTodos(String uid) async {
    try{
      _firestore.collection("Todos").doc(uid).delete();
    }
    catch(e)
    {
      throw e;
    }
  }
}
