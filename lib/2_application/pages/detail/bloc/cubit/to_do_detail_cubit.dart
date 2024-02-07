import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/usecases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_list_app/core/use_case.dart';

part 'to_do_detail_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailCubitState> {
  ToDoDetailCubit(
      {required this.collectionId, required this.loadToDoEntryIdsForCollection})
      : super(const ToDoDetailCubitLoadingState());

  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(const ToDoDetailCubitLoadingState());
    try {
      final entryIds = await loadToDoEntryIdsForCollection
          .call(CollectionIdParams(collectionId: collectionId));

      if (entryIds.isLeft) {
        emit(const ToDoDetailCubitErrorState());
      } else {
        emit(ToDoDetailCubitLoadedState(entryId: entryIds.right));
      }
    } on Exception {
      emit(const ToDoDetailCubitErrorState());
    }
  }
}
