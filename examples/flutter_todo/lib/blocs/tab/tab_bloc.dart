import 'package:bloc/bloc.dart';

import 'package:flutter_todo/blocs/tab/tab.dart';
import 'package:flutter_todo/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  updateTab(AppTab tab) {
    dispatch(UpdateTab(tab));
  }

  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(
    AppTab currentState,
    TabEvent event,
  ) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
