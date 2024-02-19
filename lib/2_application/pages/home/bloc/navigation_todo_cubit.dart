import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_cubit_state.dart';

class NavigationToDoCubit extends Cubit<NavigationToDoCubitState> {
  NavigationToDoCubit() : super(const NavigationToDoCubitState());

  void selectedToDoCollectionChangedId(CollectionId collectionId) {
    emit(NavigationToDoCubitState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    if (state.isSecondBodyDisplayed != isSecondBodyDisplayed) {
      emit(
        NavigationToDoCubitState(
          isSecondBodyDisplayed: isSecondBodyDisplayed,
          selectedCollectionId: state.selectedCollectionId,
        ),
      );
    }
  }
}
