// ignore_for_file: implementation_imports

import 'package:either_dart/src/either.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/entities/todo_color.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';

class ToDoRepositoryMock implements ToDoRepository {
  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    final list = List<ToDoCollection>.generate(
      10,
      (index) => ToDoCollection(
        id: CollectionId.fromUniqueString(index.toString()),
        color: ToDoColor(
          colorIndex: index % ToDoColor.predefinedColors.length,
        ),
        title: 'title $index',
      ),
    );
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => Right(list),
    );
  }
}
