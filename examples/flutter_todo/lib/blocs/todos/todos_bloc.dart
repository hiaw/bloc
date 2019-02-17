import 'package:bloc/bloc.dart';

import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/blocs/todos/todos.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  void addTodo(Todo todo) {
    dispatch(AddTodo(todo));
  }

  void updateTodo(Todo updatedTodo) {
    dispatch(UpdateTodo(updatedTodo));
  }

  void deleteTodo(Todo todo) {
    dispatch(DeleteTodo(todo));
  }

  @override
  TodosState get initialState => TodosState.initial();

  @override
  Stream<TodosState> mapEventToState(
    TodosState currentState,
    TodosEvent event,
  ) async* {
    if (event is AddTodo) {
      yield* mapAddTodoToState(currentState, event);
    } else if (event is UpdateTodo) {
      yield* mapUpdateTodoToState(currentState, event);
    } else if (event is DeleteTodo) {
      yield* mapDeleteTodoToState(currentState, event);
    }
  }

  Stream<TodosState> mapAddTodoToState(
    TodosState currentState,
    AddTodo event,
  ) async* {
    yield TodosState(
      List.from(currentState.todos)..add(event.todo),
    );
  }

  Stream<TodosState> mapUpdateTodoToState(
    TodosState currentState,
    UpdateTodo event,
  ) async* {
    yield TodosState(
      currentState.todos
          .map((todo) =>
              todo.id == event.updatedTodo.id ? event.updatedTodo : todo)
          .toList(),
    );
  }

  Stream<TodosState> mapDeleteTodoToState(
    TodosState currentState,
    DeleteTodo event,
  ) async* {
    yield TodosState(
      currentState.todos.where((todo) => todo.id != event.todo.id).toList(),
    );
  }
}
