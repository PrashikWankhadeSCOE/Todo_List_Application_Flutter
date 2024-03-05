import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/todo_entry.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/usecases/create_todo_entry.dart';
import 'package:todo_list_app/2_application/core/form_value.dart';
import 'package:todo_list_app/core/use_case.dart';

part 'create_todo_entry_page_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  CreateTodoEntryPageCubit({
    required this.addToDoEntry,
    required this.collectionId,
  }) : super(const CreateTodoEntryPageState());

  final CollectionId collectionId;
  final CreateToDoEntry addToDoEntry;

  void descriptionChanged({String? description}) {
    ValidationStatus currentstatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentstatus = ValidationStatus.error;
    } else {
      currentstatus = ValidationStatus.success;
    }
    emit(
      state.copyWith(
        description: FormValue(
          value: description!,
          validationStatus: currentstatus,
        ),
      ),
    );
  }

  void submit() async {
    await addToDoEntry.call(
      ToDoEntryParams(
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
      ),
    );
  }
}
