import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/models/todo.dart';

import '../blocs/todo_bloc/todo_bloc.dart';

class UpdateTodoView extends StatefulWidget {
  final Todo todo;

  UpdateTodoView({Key? key, required this.todo}) : super(key: key);

  @override
  _UpdateTodoViewState createState() => _UpdateTodoViewState();
}

class _UpdateTodoViewState extends State<UpdateTodoView> {
  @override
  // TODO: implement widget
  UpdateTodoView get widget => super.widget;

  late String new_title = widget.todo.title;
  late String new_priority = widget.todo.priority;
  late TextEditingController _controller =
      new TextEditingController(text: widget.todo.title);

  List<String> priorities = <String>["Low", "Medium", "High"];

  @override
  Widget build(BuildContext context) {
    if (!priorities.contains(widget.todo.priority))
    {
      new_priority = "Low";
    }

    print("built update view");
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(
                top: 25.0, left: 10.0, right: 10.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 20.0,
                  color: Theme.of(context).primaryColor,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "New Title",
                    ),
                    controller: _controller,
                    onChanged: (val) => new_title = val,
                  ),
                ),
                SizedBox(
                  height: 25.00,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: DropdownButton<String>(
                    value: new_priority,
                    elevation: 50,
                    onChanged: (String? value) {
                      setState(() {
                        new_priority = value!;
                      });
                    },
                    items: <String>["Low", "Medium", "High"]
                        .map<DropdownMenuItem<String>>((String value) =>
                            DropdownMenuItem<String>(
                                value: value, child: Text(value)))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print(new_priority);
              widget.todo.title = new_title;
              widget.todo.priority = new_priority;
              return BlocProvider.of<TodoBloc>(context)
                  .add(UpdateDataTodoEvent(todo: widget.todo));
            },
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
