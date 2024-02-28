import 'package:either_dart/either.dart';
import 'package:todo_list_app/1_domain/entities/todo_entry.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';
import 'package:todo_list_app/core/use_case.dart';

class LoadTodoEntry implements UseCase<ToDoEntry, ToDoEntryIdsParam> {
  const LoadTodoEntry({required this.toDoRepository});
  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdsParam params) async {
    try {
      final loadedEntry = toDoRepository.readToDoEntry(
        params.collectionId,
        params.entryId,
      );
      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
