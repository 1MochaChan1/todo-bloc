import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/cubits/nav_cubit.dart';
import 'package:time_blocin/models/todo.dart';
import 'package:time_blocin/view/add_todo_view.dart';
import 'package:time_blocin/view/todo_view.dart';
import 'package:time_blocin/view/update_todo_view.dart';

/// Handles the navigation and pages
/// based on NavCubits emits.

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // wrapping in bloc builder to check for _todo.
    return BlocBuilder<NavCubit, Todo>(
      builder: (context, todo) {
        return Navigator(
          pages: [
            MaterialPage(child: TodoView()),
            // no curly braces here.
            if (todo.id != "") MaterialPage(child: UpdateTodoView(todo: todo)),
            if (todo.id == "add todo") MaterialPage(child: AddTodoView())
          ],
          /// onPopPage is invoked whenever a page
          /// in the pages list is popped.

          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToHome();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
