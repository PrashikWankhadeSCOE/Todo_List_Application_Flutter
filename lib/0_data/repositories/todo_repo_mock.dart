// ignore_for_file: implementation_imports

import 'package:either_dart/src/either.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/entities/todo_color.dart';
import 'package:todo_list_app/1_domain/entities/todo_entry.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';

class ToDoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> toDoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      description: 'description $index',
      id: EntryId.fromUniqueString(index.toString()),
      isDone: false,
    ),
  );

  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      color: ToDoColor(
        colorIndex: index % ToDoColor.predefinedColors.length,
      ),
      title: 'title $index',
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem =
          toDoEntries.firstWhere((element) => element.id == entryId);

      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(selectedEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) {
    try {
      final startindex = int.parse(collectionId.value) * 10;
      final endIndex = startindex + 10;
      final entryIds = toDoEntries
          .sublist(startindex, endIndex)
          .map((entry) => entry.id)
          .toList();
      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
