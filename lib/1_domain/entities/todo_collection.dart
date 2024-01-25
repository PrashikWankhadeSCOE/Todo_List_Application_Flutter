import 'package:todo_list_app/1_domain/entities/todo_color.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';

class ToDoCollection {
  final CollectionId id;
  final String title;
  final ToDoColor color;

  ToDoCollection({
    required this.id,
    required this.color,
    required this.title,
  });

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: "",
      color: ToDoColor(colorIndex: 0),
    );
  }
}