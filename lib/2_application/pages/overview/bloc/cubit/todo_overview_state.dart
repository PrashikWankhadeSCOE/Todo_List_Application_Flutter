part of 'todo_overview_cubit.dart';

sealed class TodoOverviewCubitState extends Equatable {
  const TodoOverviewCubitState();

  @override
  List<Object> get props => [];
}

class ToDoOverviewCubitLoadingState extends TodoOverviewCubitState {
  const ToDoOverviewCubitLoadingState();
}

class ToDoOverviewCubitErrorState extends TodoOverviewCubitState {
  const ToDoOverviewCubitErrorState();
}

final class ToDoOverviewCubitLoadedState extends TodoOverviewCubitState {
  const ToDoOverviewCubitLoadedState({required this.collections});
  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [collections];
}
