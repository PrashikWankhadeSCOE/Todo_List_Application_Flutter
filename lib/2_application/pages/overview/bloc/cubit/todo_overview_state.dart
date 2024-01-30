part of 'todo_overview_cubit.dart';

sealed class TodoOverviewCubitState extends Equatable {
  const TodoOverviewCubitState();

  @override
  List<Object> get props => [];
}

final class ToDoOverviewCubitLoadingState extends TodoOverviewCubitState {}

final class ToDoOverviewCubitErrorState extends TodoOverviewCubitState {}

final class ToDoOverviewCubitLoadedState extends TodoOverviewCubitState {
  const ToDoOverviewCubitLoadedState({required this.collections});
  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [collections];
}
