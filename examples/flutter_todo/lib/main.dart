import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/container/container.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

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
        title: 'Bloc Todos',
        home: Home(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[800],
          accentColor: Colors.cyan[300],
          buttonColor: Colors.grey[800],
          textSelectionColor: Colors.cyan[100],
          backgroundColor: Colors.grey[800],
          toggleableActiveColor: Colors.cyan[300],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _todosBloc.dispose();
    super.dispose();
  }
}
