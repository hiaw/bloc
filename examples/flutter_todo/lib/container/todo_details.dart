import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/presentation/presentation.dart';
import 'package:flutter_todo/edit_todo.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  final VoidCallback onCheckboxChanged;
  final VoidCallback onRemove;
  final VoidCallback onUndoRemove;
  final Function(Todo) onTodoUpdated;

  TodoDetails({
    Key key,
    @required this.todo,
    @required this.onCheckboxChanged,
    @required this.onRemove,
    @required this.onUndoRemove,
    @required this.onTodoUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onRemove,
          )
        ],
      ),
      body: todo == null
          ? Container()
          : TodoItem(
              todo: todo,
              onCheckboxChanged: onCheckboxChanged,
              onDismissed: null,
              onTap: null,
            ),
      floatingActionButton: todo == null
          ? null
          : FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () async {
                final updatedTodo = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditTodo(
                        todo: todo,
                      );
                    },
                  ),
                );
                if (updatedTodo != null) {
                  onTodoUpdated(updatedTodo);
                }
              },
            ),
    );
  }
}
