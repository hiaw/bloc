import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/todos_bloc.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final TodosBloc _todosBloc = TodosBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      bloc: _todosBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Todos(),
      ),
    );
  }

  @override
  void dispose() {
    _todosBloc.dispose();
    super.dispose();
  }
}

class Todos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: TodosList(),
    );
  }
}

class TodosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TodosBloc>(context),
      builder: (BuildContext context, TodosState state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (_, index) {
            return ListTile(title: Text(state.todos[index].value));
          },
        );
      },
    );
  }
}
