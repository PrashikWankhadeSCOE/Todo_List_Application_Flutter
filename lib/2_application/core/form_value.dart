import 'package:equatable/equatable.dart';

class FormValue<T> with EquatableMixin {
  final T value;
  final ValidationStatus validationStatus;
  FormValue({required this.validationStatus, required this.value});
  @override
  List<Object?> get props => [value, validationStatus];
}

enum ValidationStatus {
  error,
  success,
  pending,
}
