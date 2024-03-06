import 'package:either_dart/either.dart';
import 'package:todo_list_app/0_data/data_sources/interfaces/todo_local_data_source_inteface.dart';
import 'package:todo_list_app/0_data/exceptions/exceptions.dart';
import 'package:todo_list_app/0_data/models/todo_collection_model.dart';
import 'package:todo_list_app/0_data/models/todo_entry_model.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/entities/todo_color.dart';
import 'package:todo_list_app/1_domain/entities/todo_entry.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/failures/failures.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';

class ToDoRepositoryLocal extends ToDoRepository {
  ToDoRepositoryLocal({required this.localDataSource});
  final ToDoLocalDataSourceInterface localDataSource;
  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) async {
    try {
      final result = await localDataSource.createToDoCollection(
          collection: toDoCollectionModel(collection));
      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry) async {
    try {
      final result = await localDataSource.createToDoEntry(
        collectionId: collectionId,
        entry: toDoEntryToModel(entry),
      );

      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    try {
      final collectionIds = await localDataSource.getToDoCollectionIds();
      final List<ToDoCollection> collections = [];
      for (String collectionId in collectionIds) {
        final collection =
            await localDataSource.getToDoCollection(collectionId: collectionId);
        collections.add(toDoCollectionModelToEntity(collection));
      }
      return Right(collections);
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await localDataSource.getToDoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      return Right(toDoEntryModelToEntity(result));
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) async {
    try {
      final entries = await localDataSource.getToDoEntryIds(
        collectionId: collectionId.value,
      );
      return Right(
        entries.map((id) => EntryId.fromUniqueString(id)).toList(),
      );
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    try {
      final entry = await localDataSource.updateToDoEntry(
          collectionId: collectionId.value, entryId: entryId.value);
      return Right(toDoEntryModelToEntity(entry));
    } on CacheException catch (e) {
      return Future.value(Left(ChacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  ToDoEntry toDoEntryModelToEntity(ToDoEntryModel model) {
    final entity = ToDoEntry(
      description: model.description,
      id: EntryId.fromUniqueString(model.id),
      isDone: model.isDone,
    );
    return entity;
  }

  ToDoCollection toDoCollectionModelToEntity(ToDoCollectionModel model) {
    final entity = ToDoCollection(
      title: model.title,
      id: CollectionId.fromUniqueString(model.id),
      color: ToDoColor(colorIndex: model.colorIndex),
    );
    return entity;
  }

  ToDoEntryModel toDoEntryToModel(ToDoEntry entry) {
    final model = ToDoEntryModel(
      description: entry.description,
      id: entry.id.value,
      isDone: entry.isDone,
    );
    return model;
  }

  ToDoCollectionModel toDoCollectionModel(ToDoCollection collection) {
    final model = ToDoCollectionModel(
      title: collection.title,
      id: collection.id.value,
      colorIndex: collection.color.colorIndex,
    );
    return model;
  }
}
