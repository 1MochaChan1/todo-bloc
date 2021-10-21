import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/data/service_provider.dart';
import 'package:time_blocin/models/todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

/// Decides what Data(state) to emit on certain Events.

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final dataService = DataService();
  StreamSubscription? _streamSubscription;

  TodoBloc() : super(GettingTodoState()) {
    on<GetTodoEvent>(_onGetTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<PutTodoEvent>(_onPutTodoEvent);
    on<UpdateDataTodoEvent>(_onUpdateDataTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  void _onGetTodoEvent(GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(GettingTodoState());

    try {
      final todos = dataService.getTodos(); // -> returns a Stream
      _streamSubscription?.cancel();

      // adding the list to the given event.
      _streamSubscription = todos.listen((event) {
        return add(UpdateTodoEvent(todoList: event));
      });
    } catch (e) {
      emit(FailedToGetTodoState(err: e));
    }
  }

  void _onUpdateTodoEvent(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(GotTodoState(todoSnap: event.todoList));
  }

  void _onPutTodoEvent(PutTodoEvent event, Emitter<TodoState> emit) async {
    emit(PuttingTodoState());

    try {
      await dataService.putTodos(event.title, event.priority);
      emit(PutTodoState(title: event.title));

      final todos = dataService.getTodos(); // -> returns a Stream
      _streamSubscription?.cancel();
      _streamSubscription = todos.listen((list) {
        return add(UpdateTodoEvent(todoList: list));
      });
    } catch (e) {
      emit(FailedToPutTodoState(err: e));
    }
  }

  void _onUpdateDataTodoEvent(
      UpdateDataTodoEvent event, Emitter<TodoState> emit) {
    final todo = event.todo;

    try {
      dataService.updateTodos(todo);

      final todos = dataService.getTodos();
      _streamSubscription?.cancel();

      _streamSubscription =
          todos.listen((list) => add(UpdateTodoEvent(todoList: list)));
    } catch (e) {
      emit(FailedToPutTodoState(err: e));
    }
  }

  void _onDeleteTodoEvent(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final uid = event.uid;
    try {
      dataService.deleteTodos(uid);

      final todos = dataService.getTodos();
      _streamSubscription?.cancel();

      _streamSubscription =
          todos.listen((list) => add(UpdateTodoEvent(todoList: list)));
    } catch (e) {
      throw (e);
    }
  }
}
