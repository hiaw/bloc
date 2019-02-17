import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';

class TodoItem extends StatelessWidget {
  final VoidCallback onDismissed;
  final GestureTapCallback onTap;
  final VoidCallback onCheckboxChanged;
  final Todo todo;

  const TodoItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.todo,
    @required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('TodoItem_${todo.id}'),
      onDismissed: (_) => onDismissed(),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.isComplete,
          onChanged: (_) => onCheckboxChanged(),
        ),
        title: Text(todo.task),
        subtitle: todo.note.isEmpty
            ? null
            : Text(
                todo.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
