import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';

class ToDoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  const ToDoEntry(
      {required this.description, required this.id, required this.isDone});

  factory ToDoEntry.empty() {
    return ToDoEntry(
      description: '',
      id: EntryId(),
      isDone: false,
    );
  }

  ToDoEntry copyWith({
    String? description,
    bool? isDone,
  }) {
    return ToDoEntry(
      description: description ?? this.description,
      id: id,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, isDone, description];
}
