part of 'to_do_detail_cubit.dart';

sealed class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object> get props => [];
}

final class ToDoDetailCubitLoadingState extends ToDoDetailCubitState {
  const ToDoDetailCubitLoadingState();
}

final class ToDoDetailCubitLoadedState extends ToDoDetailCubitState {
  const ToDoDetailCubitLoadedState({required this.entryId});
  final List<EntryId> entryId;

  @override
  List<Object> get props => [entryId];
}

final class ToDoDetailCubitErrorState extends ToDoDetailCubitState {
  const ToDoDetailCubitErrorState();
}
