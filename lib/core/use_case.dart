import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ToDoEntryIdsParam extends Params {
  final CollectionId collectionId;
  final EntryId entryId;

  ToDoEntryIdsParam({required this.collectionId, required this.entryId})
      : super();

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParams extends Params {
  final CollectionId collectionId;

  CollectionIdParams({required this.collectionId}) : super();

  @override
  List<Object?> get props => [collectionId];
}
