import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_todo/todo.dart';

class TodosState extends Equatable {
  final List<Todo> todos;

  TodosState({this.todos = const []}) : super([todos]);
}

abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const []]) : super(props);
}

class AddTodo extends TodosEvent {
  final todo;

  AddTodo({this.todo}) : super([todo]);
}

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  @override
  TodosState get initialState => TodosState(todos: [Todo(value: 'wash car')]);

  @override
  Stream<TodosState> mapEventToState(
    TodosState currentState,
    TodosEvent event,
  ) async* {
    if (event is AddTodo) {
      yield TodosState(todos: currentState.todos + event.todo);
    }
  }
}
