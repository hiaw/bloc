import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;

  EditTodo({Key key, @required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  Todo get todo => widget.todo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: todo.task,
                autofocus: false,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'todo cannot be empty' : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: todo.note,
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'save changes',
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            Navigator.pop(context, Todo(_task, note: _note, id: todo.id));
          }
        },
      ),
    );
  }
}
