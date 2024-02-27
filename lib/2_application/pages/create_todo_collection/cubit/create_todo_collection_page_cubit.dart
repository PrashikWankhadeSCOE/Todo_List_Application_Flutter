import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/todo_collection.dart';
import 'package:todo_list_app/1_domain/entities/todo_color.dart';
import 'package:todo_list_app/core/use_case.dart';

import '../../../../1_domain/usecases/create_todo_collection.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit
    extends Cubit<CreateTodoCollectionPageState> {
  CreateTodoCollectionPageCubit({required this.createTodoCollection})
      : super(const CreateTodoCollectionPageState());

  final CreateToDoCollection createTodoCollection;

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '') ?? 0;
    await createTodoCollection.call(
      ToDoCollectionParams(
        collection: ToDoCollection.empty().copyWith(
          title: state.title,
          color: ToDoColor(
            colorIndex: parsedColorIndex,
          ),
        ),
      ),
    );
  }
}
