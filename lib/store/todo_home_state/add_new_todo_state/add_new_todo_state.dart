import 'package:mobx/mobx.dart';

part 'add_new_todo_state.g.dart';

// ignore: library_private_types_in_public_api
class AddNewTodoState = _AddNewTodoState with _$AddNewTodoState;

abstract class _AddNewTodoState with Store {
  @observable
  DateTime? selectedDate;

  @observable
  String? errorMessage;
}
