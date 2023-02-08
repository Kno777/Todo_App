// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_home_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoHomeState on _TodoHomeState, Store {
  late final _$todosAtom = Atom(name: '_TodoHomeState.todos', context: context);

  @override
  ObservableList<TodoModel> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<TodoModel> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  late final _$currentPageIndexAtom =
      Atom(name: '_TodoHomeState.currentPageIndex', context: context);

  @override
  int get currentPageIndex {
    _$currentPageIndexAtom.reportRead();
    return super.currentPageIndex;
  }

  @override
  set currentPageIndex(int value) {
    _$currentPageIndexAtom.reportWrite(value, super.currentPageIndex, () {
      super.currentPageIndex = value;
    });
  }

  late final _$_TodoHomeStateActionController =
      ActionController(name: '_TodoHomeState', context: context);

  @override
  void addTodo(TodoModel todo) {
    final _$actionInfo = _$_TodoHomeStateActionController.startAction(
        name: '_TodoHomeState.addTodo');
    try {
      return super.addTodo(todo);
    } finally {
      _$_TodoHomeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(TodoModel todo) {
    final _$actionInfo = _$_TodoHomeStateActionController.startAction(
        name: '_TodoHomeState.removeTodo');
    try {
      return super.removeTodo(todo);
    } finally {
      _$_TodoHomeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTodo(TodoModel todo) {
    final _$actionInfo = _$_TodoHomeStateActionController.startAction(
        name: '_TodoHomeState.updateTodo');
    try {
      return super.updateTodo(todo);
    } finally {
      _$_TodoHomeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos},
currentPageIndex: ${currentPageIndex}
    ''';
  }
}
