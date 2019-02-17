import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/presentation/presentation.dart';
import 'package:flutter_todo/container/container.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onCheckboxChanged;
  final Function(Todo) onRemove;
  final Function(Todo) onUndoRemove;
  final Function(Todo) onUpdated;

  TodoList({
    Key key,
    @required this.todos,
    @required this.onCheckboxChanged,
    @required this.onRemove,
    @required this.onUndoRemove,
    @required this.onUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onTap: () => _onTodoTap(context, todo),
          onDismissed: () => _removeTodo(context, todo),
          onCheckboxChanged: () => onCheckboxChanged(todo),
        );
      },
    );
  }

  _removeTodo(BuildContext context, Todo todo) {
    onRemove(todo);
    Scaffold.of(context).showSnackBar(
      DeleteTodoSnackBar(
        todo: todo,
        onUndo: () => onUndoRemove(todo),
      ),
    );
  }

  _onTodoTap(BuildContext context, Todo todo) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => TodoDetails(
              todo: todo,
              onCheckboxChanged: () => onCheckboxChanged(todo),
              onRemove: () => _removeTodo(context, todo),
              onUndoRemove: () => onUndoRemove(todo),
              onTodoUpdated: onUpdated,
            ),
      ),
    )
        .then(
      (removedTodo) {
        if (removedTodo == null) {
          return;
        }
        _removeTodo(context, todo);
      },
    );
  }
}
