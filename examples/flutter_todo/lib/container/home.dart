import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/blocs/blocs.dart' hide AddTodo;
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/add_todo.dart';
import 'package:flutter_todo/tab_selector.dart';
import 'package:flutter_todo/presentation/presentation.dart';
import 'package:flutter_todo/stats.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TabBloc _tabBloc = TabBloc();

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder(
      bloc: _tabBloc,
      builder: (BuildContext context, AppTab tab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bloc Todos'),
          ),
          body: BlocBuilder(
            bloc: todosBloc,
            builder: (BuildContext context, TodosState state) {
              return tab == AppTab.stats
                  ? Stats()
                  : TodoList(
                      todos: state.todos,
                      onCheckboxChanged: (todo) => todosBloc.updateTodo(
                            todo.copyWith(isComplete: !todo.isComplete),
                          ),
                      onRemove: (todo) => todosBloc.deleteTodo(todo),
                      onUndoRemove: (todo) => todosBloc.addTodo(todo),
                      onUpdated: (updatedTodo) =>
                          todosBloc.updateTodo(updatedTodo),
                    );
            },
          ),
          bottomNavigationBar: TabSelector(
            activeTab: tab,
            onTabChanged: (tab) => _tabBloc.updateTab(tab),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final todo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(),
                ),
              );
              if (todo != null) {
                todosBloc.addTodo(todo);
              }
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabBloc.dispose();
    super.dispose();
  }
}
