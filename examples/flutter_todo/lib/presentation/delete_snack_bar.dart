import 'package:flutter/material.dart';

import 'package:flutter_todo/models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({Key key, Todo todo, VoidCallback onUndo})
      : super(
          content: Text(
            'Deleted ${todo.task}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
