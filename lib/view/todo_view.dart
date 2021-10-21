import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/cubits/nav_cubit.dart';
import 'package:time_blocin/models/todo.dart';

import '../blocs/todo_bloc/todo_bloc.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    String title_text = "";
    String dropdownVal = "Low";
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding:
              EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Todos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              Divider(
                indent: 20.0,
                endIndent: 20.0,
                color: Theme.of(context).primaryColor,
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  child: BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state is GettingTodoState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GotTodoState) {
                        print("rebuilt");
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.todoSnap.length,
                            itemBuilder: (context, index) {
                              final _todoList = state.todoSnap;
                              return ListTile(
                                title: Text(_todoList[index].title),
                                trailing: IconButton(
                                  onPressed: () => _deleteTodo(_todoList[index].id, context),
                                  icon: Icon(Icons.delete),
                                ),
                                onTap: () => BlocProvider.of<NavCubit>(context)
                                    .showUpdateView(_todoList[index]),
                                subtitle: Text("Priority: "+_todoList[index].priority),
                              );
                            });
                      } else if (state is FailedToGetTodoState) {
                        return Text(state.err.toString());
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => BlocProvider.of<NavCubit>(context)
              .showTodoView(Todo(id: "add todo", priority: '', title: '')),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void _deleteTodo(String uid, BuildContext context){
  return BlocProvider.of<TodoBloc>(context)
      .add(DeleteTodoEvent(uid: uid));
}
