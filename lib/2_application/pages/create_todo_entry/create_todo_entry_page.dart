import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';
import 'package:todo_list_app/1_domain/usecases/create_todo_entry.dart';
import 'package:todo_list_app/2_application/core/form_value.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';
import 'package:todo_list_app/2_application/pages/create_todo_entry/bloc/create_todo_entry_page_cubit.dart';

typedef ToDoEntryItemAddedCallback = Function();

class CreateToDoEntryPageExtra {
  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback todoEntryItemAddedCallback;
  CreateToDoEntryPageExtra({
    required this.collectionId,
    required this.todoEntryItemAddedCallback,
  });
}

class CreateToDoEntryPageProvider extends StatelessWidget {
  const CreateToDoEntryPageProvider({
    super.key,
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryPageCubit>(
      create: (context) => CreateTodoEntryPageCubit(
        collectionId: collectionId,
        addToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateToDoEntryPage(
        toDoEntryItemAddedCallback: toDoEntryItemAddedCallback,
      ),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({
    super.key,
    required this.toDoEntryItemAddedCallback,
  });
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_entry',
    child: Placeholder(),
  );

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'description'),
                onChanged: (value) {
                  context
                      .read<CreateTodoEntryPageCubit>()
                      .descriptionChanged(description: value);
                },
                validator: (value) {
                  final currentValidationStatus = context
                          .read<CreateTodoEntryPageCubit>()
                          .state
                          .description
                          ?.validationStatus ??
                      ValidationStatus.pending;
                  switch (currentValidationStatus) {
                    case ValidationStatus.error:
                      return 'this field needs at least two character to be valid';
                    case ValidationStatus.success:
                    case ValidationStatus.pending:
                      return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate();
                  if (isValid == true) {
                    context.read<CreateTodoEntryPageCubit>().submit();
                    widget.toDoEntryItemAddedCallback.call();
                    context.pop(true);
                  }
                },
                child: const Text('Save Entry'),
              ),
            ],
          )),
    );
  }
}
