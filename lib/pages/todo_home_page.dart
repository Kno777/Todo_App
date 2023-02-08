import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widgets/todo_list_view.dart';
import 'package:todo_app/widgets/update_todo.dart';
import '../models/todo_model.dart';
import '../store/todo_home_state/todo_home_state.dart';
import '../widgets/add_new_todo.dart';
import 'completed_todo_page.dart';
import 'pending_todo_page.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({
    super.key,
  });

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final _todoHomeState = TodoHomeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.task,
          ),
          onPressed: () => _navigateCompletedTodoPage(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.pending_actions,
            ),
            onPressed: () => _navigatePendingTodoPage(context),
          ),
        ],
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          Observer(
            builder: (_) => TodoListView(
              todos: _todoHomeState.todos,
              deleteTodo: _todoHomeState.removeTodo,
              updateTodo: _updateTodoModel,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //           Icons.task
      //       ),
      //       label: 'Done',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.pending_actions,
      //       ),
      //       label: 'Pending',
      //     ),
      //   ],
      //   onTap: _goCompletedOrPendingTodoPage,
      //   selectedItemColor: Colors.orange,
      //   currentIndex: _todoHomeState.currentPageIndex,
      // ),
    );
  }

  Future<void> _startAddNewTransaction(BuildContext ctx) async {
    final todo = await showModalBottomSheet<TodoModel>(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: const AddNewTodo(),
        );
      },
    );

    if (todo is TodoModel) {
      _todoHomeState.addTodo(todo);
    }
  }

  Future<void> _updateTodoModel(BuildContext ctx, TodoModel todo) async {
    final x = await showModalBottomSheet<TodoModel>(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: UpdateTodo(todos: todo),
        );
      },
    );

    if (x is TodoModel) {
      _todoHomeState.updateTodo(x);
    }
  }

// void _goCompletedOrPendingTodoPage(int index) {
//   _todoHomeState.currentPageIndex = index;
// }
//
// static const List<Widget> _currentWidgets = <Widget>[
//   CompletedTodoPage(),
//   PendingTodoPage(),
// ];

  void _navigateCompletedTodoPage(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => CompletedTodoPage(
            todos: _todoHomeState.todos,
            deleteTodo: _todoHomeState.removeTodo,
            updateTodo: _updateTodoModel),
      ),
    );
  }

  void _navigatePendingTodoPage(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => PendingTodoPage(
          todos: _todoHomeState.todos,
          deleteTodo: _todoHomeState.removeTodo,
          updateTodo: _updateTodoModel,
        ),
      ),
    );
  }
}
