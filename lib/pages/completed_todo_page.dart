import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../models/todo_model.dart';

class CompletedTodoPage extends StatelessWidget {
  const CompletedTodoPage({
    super.key,
    required this.todos,
    required this.deleteTodo,
    required this.updateTodo,
  });

  final List<TodoModel> todos;
  final Function(TodoModel) deleteTodo;
  final Function(BuildContext, TodoModel) updateTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Todos',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Observer(
            builder: (_) => Flexible(
              child: Container(
                height: 550,
                child: todos.isNotEmpty
                    ? ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (_, index) {
                          return todos[index].done
                              ? Observer(
                                  builder: (context) => CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: todos[index].done,
                                    onChanged: (_) {
                                      todos[index] = TodoModel(
                                        id: todos[index].id,
                                        title: todos[index].title,
                                        description: todos[index].description,
                                        date: todos[index].date,
                                        done: todos[index].done ? false : true,
                                      );
                                    },
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            todos[index].title,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            todos[index].description,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            DateFormat.yMMMd()
                                                .format(todos[index].date),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () =>
                                              deleteTodo(todos[index]),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () =>
                                              updateTodo(context, todos[index]),
                                        )
                                      ],
                                    ),
                                  ),
                                ) : SizedBox();
                              // : Container(
                              //     alignment: Alignment.center,
                              //     margin: const EdgeInsets.all(10),
                              //     padding: const EdgeInsets.all(10),
                              //     child: const Text(
                              //       "You don\'t have any completed todos",
                              //       style: TextStyle(
                              //           fontSize: 28,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   );
                        },
                      )
                    : Column(
                        children: [
                          Text(
                            'No todos added yet!',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/images/waiting.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
