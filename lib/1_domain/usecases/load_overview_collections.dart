import 'package:either_dart/either.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';
import 'package:todo_list_app/core/use_case.dart';

class LoadTodoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  final ToDoRepository toDoRepository;

  const LoadTodoCollections({required this.toDoRepository});

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(params) async {
    try {
      final loadedCollections = toDoRepository.readToDoCollections();
      return loadedCollections.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          stackTrace: e.toString(),
        ),
      );
    }
  }
}
