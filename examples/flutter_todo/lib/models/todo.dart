import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Todo extends Equatable {
  final bool isComplete;
  final String id;
  final String note;
  final String task;

  Todo(this.task, {this.isComplete = false, String note, String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().v4(),
        super([task, isComplete, note, id]);

  Todo copyWith({
    bool isComplete,
    String note,
    String task,
  }) {
    return Todo(      
      task ?? this.task,
      isComplete: isComplete ?? this.isComplete,
      note: note ?? this.note,
      id: id ?? this.id,
    );
  }

  @override
  String toString() =>
      'Todo { isComplete: $isComplete, id: $id, note: $note, task: $task }';
}
