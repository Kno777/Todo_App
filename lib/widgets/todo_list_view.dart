import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListView extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(TodoModel) deleteTodo;
  final Function(BuildContext, TodoModel) updateTodo;

  TodoListView({
    Key? key,
    required this.todos,
    required this.deleteTodo,
    required this.updateTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Flexible(
        child: Container(
          height: 550,
          child: todos.isNotEmpty
              ? ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, index) {
                    return Observer(
                      builder: (context) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
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
                                DateFormat.yMMMd().format(todos[index].date),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteTodo(todos[index]),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  updateTodo(context, todos[index]),
                            )
                          ],
                        ),
                      ),
                    );
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
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
