import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/usecases/load_overview_collections.dart';
import 'package:todo_list_app/core/use_case.dart';
part 'todo_overview_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewCubitState> {
  TodoOverviewCubit({
    required this.loadTodoCollections,
    TodoOverviewCubitState? initialState,
  }) : super(initialState ?? ToDoOverviewCubitLoadingState());

  final LoadTodoCollections loadTodoCollections;

  Future<void> readToDoCollections() async {
    emit(ToDoOverviewCubitLoadingState());
    try {
      final collectionsFuture = loadTodoCollections.call(NoParams());
      final collections = await collectionsFuture;
      if (collections.isLeft) {
        emit(ToDoOverviewCubitErrorState());
      } else {
        emit(ToDoOverviewCubitLoadedState(collections: collections.right));
      }
    } on Exception {
      emit(ToDoOverviewCubitErrorState());
    }
  }
}
