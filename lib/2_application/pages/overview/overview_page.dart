import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/1_domain/usecases/load_overview_collections.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';
import 'package:todo_list_app/2_application/pages/overview/bloc/cubit/todo_overview_cubit.dart';
import 'package:todo_list_app/2_application/pages/overview/view_states/todo_overview_errors.dart';
import 'package:todo_list_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_list_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverviewCubit(
        loadTodoCollections: LoadTodoCollections(
          toDoRepository: RepositoryProvider.of(context),
        ),
      )..readToDoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageconfig = PageConfig(
    icon: Icons.history_edu_outlined,
    name: 'overview',
    child: OverviewPageProvider(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: BlocBuilder<TodoOverviewCubit, TodoOverviewCubitState>(
        builder: (context, state) {
          if (state is ToDoOverviewCubitLoadingState) {
            return const ToDoOverviewLoading();
          } else if (state is ToDoOverviewCubitLoadedState) {
            return ToDoOverviewLoaded(collections: state.collections);
          } else {
            return const ToDoOverviewError();
          }
        },
      ),
    );
  }
}
