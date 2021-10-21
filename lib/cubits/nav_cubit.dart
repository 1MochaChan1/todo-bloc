import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/models/todo.dart';

/// Emits an Object (state) Todo
/// which is taken by the navigator
/// to decide which page to show.

class NavCubit extends Cubit<Todo>
{
  // the _todo is just a place holder.
  NavCubit():super(Todo(id: "", title: "", priority: ""));

  void showUpdateView(Todo todo) => emit(todo);

  void showTodoView(Todo todo) => emit(todo);

  void popToHome() => emit(Todo(id: "", title: "", priority: ""));
}