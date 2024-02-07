part of 'todo_entry_item_cubit.dart';

sealed class TodoEntryItemState extends Equatable {
  const TodoEntryItemState();

  @override
  List<Object> get props => [];
}

final class TodoEntryItemLoadingState extends TodoEntryItemState {}

final class TodoEntryItemLoadedState extends TodoEntryItemState {
  const TodoEntryItemLoadedState({required this.toDoEntry});
  final ToDoEntry toDoEntry;

  @override
  List<Object> get props => [toDoEntry];
}

final class TodoEntryItemErrorState extends TodoEntryItemState {}
