import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/app.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({Key? key}) : super(key: key);

  @override
  _AddTodoViewState createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  late String _title;
  String _priority = "Low";
  TextEditingController _controller = new TextEditingController();

  List<String> priorities = <String>["Low", "Medium", "High"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    "Add Todo",
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
                width: MediaQuery.of(context).size.width/1.3,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "New Todo Title",
                    labelText: "Title"
                  ),
                  onChanged: (val) => _title = val,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                child: DropdownButtonFormField<String>(
                  hint: Text("Priority"),
                  value: _priority,
                  elevation: 50,
                  onChanged: (String? value)
                  {
                    _priority = value!;
                  },
                  items: <String>["Low", "Medium", "High"]
                      .map<DropdownMenuItem<String>>((String value) =>
                      DropdownMenuItem<String>(
                          value: value, child: Text(value)))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _controller.clear();
              return BlocProvider.of<TodoBloc>(context).add(
                  PutTodoEvent(title: _title, priority: _priority));
            },
            child: Icon(Icons.check)),
      ),
    );
  }
}
