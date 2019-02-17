import 'package:equatable/equatable.dart';

import 'package:flutter_todo/models/models.dart';

class TodosState extends Equatable {
  final List<Todo> todos;

  TodosState([this.todos = const []]) : super([todos]);

  @override
  String toString() => 'TodosState { todos: $todos }';

  factory TodosState.initial() => TodosState([]);
}
