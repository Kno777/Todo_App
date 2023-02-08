import 'package:mobx/mobx.dart';

import '../../models/todo_model.dart';

part 'todo_home_state.g.dart';

// ignore: library_private_types_in_public_api
class TodoHomeState = _TodoHomeState with _$TodoHomeState;

abstract class _TodoHomeState with Store {

  @observable
  ObservableList<TodoModel> todos = ObservableList<TodoModel>.of([]);

  @observable
  int currentPageIndex = 0;

  @action
  void addTodo(TodoModel todo) {
    todos.add(todo);
  }

  @action
  void removeTodo(TodoModel todo) {
    todos.removeWhere((td) => td.id == todo.id);
  }

  @action
  void updateTodo(TodoModel todo) {
    final index = todos.indexWhere((element) => todo.id == element.id);

    if (index != -1) {
      todos[index] = todo;
    }
  }
}
