import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/1_domain/repositories/todo_repo.dart';
import 'package:todo_list_app/1_domain/usecases/load_todo_entry.dart';
import 'package:todo_list_app/1_domain/usecases/update_todo_entry.dart';
import 'package:todo_list_app/2_application/components/todo_entry_item/bloc/cubit/todo_entry_item_cubit.dart';
import 'package:todo_list_app/2_application/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:todo_list_app/2_application/components/todo_entry_item/view_states/todo_entry_item_loading.dart';

import 'view_states/todo_entry_item_loaded.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  const ToDoEntryItemProvider(
      {super.key, required this.collectionId, required this.entryId});

  final CollectionId collectionId;
  final EntryId entryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
        uploadToDoEntry: UpdateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
        collectionId: collectionId,
        entryId: entryId,
        loadTodoEntry: LoadTodoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: const ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
      builder: (context, state) {
        if (state is TodoEntryItemLoadingState) {
          return const TodoEntryItemLoading();
        } else if (state is TodoEntryItemLoadedState) {
          return TodoEntryItemLoaded(
            entryItem: state.toDoEntry,
            onChanged: (value) => context.read<TodoEntryItemCubit>().update(),
          );
        } else {
          return const TodoEntryItemError();
        }
      },
    );
  }
}
