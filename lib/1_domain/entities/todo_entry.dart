import 'package:todo_list_app/1_domain/entities/unique_id.dart';

class ToDoEntry {
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
}
