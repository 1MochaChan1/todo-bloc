part of 'todo_bloc.dart';

/// States define on a certain event what data or
/// what type of data should be returned(emitted)

abstract class TodoState {}

// for GetTodoEvent
class GettingTodoState extends TodoState {}

class GotTodoState extends TodoState {
  List<Todo> todoSnap;

  GotTodoState({required this.todoSnap});
}

class FailedToGetTodoState extends TodoState {
  Object? err;

  FailedToGetTodoState({required this.err});
}


// for PutTodoEvent
class PuttingTodoState extends TodoState {}

class PutTodoState extends TodoState {
  String title;
  PutTodoState({required this.title});
}

class FailedToPutTodoState extends TodoState {
  Object? err;
  FailedToPutTodoState({required this.err});
}
