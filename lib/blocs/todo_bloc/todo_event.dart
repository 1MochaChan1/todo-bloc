
part of 'todo_bloc.dart';

/// Events are used as a medium of input from user.
/// Can be triggered to notify the bloc for some operation.


abstract class TodoEvent {}

class GetTodoEvent extends TodoEvent {}

class UpdateTodoEvent extends TodoEvent {
  final List<Todo> todoList;
  UpdateTodoEvent({required this.todoList});
}

class PutTodoEvent extends TodoEvent {
  final String title;
  final String? priority;
  PutTodoEvent({required this.title, this.priority});
}

class UpdateDataTodoEvent extends TodoEvent{
  final Todo todo;
  UpdateDataTodoEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent{
  final String uid;
  DeleteTodoEvent({required this.uid});
}