import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String value;
  final bool isDone;

  Todo({this.value, this.isDone = false}) : super([value, isDone]);
}
