import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';

class AddTodo extends StatefulWidget {
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                autofocus: true,
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
                initialValue: '',
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
        tooltip: 'add todo',
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            Navigator.pop(context, Todo(_task, note: _note));
          }
        },
      ),
    );
  }
}
