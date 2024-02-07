import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/todo_entry.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/usecases/load_todo_entry.dart';
import 'package:todo_list_app/1_domain/usecases/update_todo_entry.dart';
import 'package:todo_list_app/core/use_case.dart';

part 'todo_entry_item_cubit_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;
  final UpdateToDoEntry uploadToDoEntry;

  TodoEntryItemCubit({
    required this.collectionId,
    required this.entryId,
    required this.loadTodoEntry,
    required this.uploadToDoEntry,
  }) : super(TodoEntryItemLoadingState());

  Future<void> fetch() async {
    try {
      final entry = await loadTodoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );
      return entry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadToDoEntry.call(ToDoEntryIdsParam(
        collectionId: collectionId,
        entryId: entryId,
      ));
      return updatedEntry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }
}
