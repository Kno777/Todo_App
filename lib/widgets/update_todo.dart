import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';

import '../store/todo_home_state/add_new_todo_state/add_new_todo_state.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({
    super.key,
    required this.todos,
  });

  final TodoModel todos;

  @override
  State<UpdateTodo> createState() => _UpdateTodo();
}

class _UpdateTodo extends State<UpdateTodo> {
  final _addNewTodoState = AddNewTodoState();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todos.title;
    _descriptionController.text = widget.todos.description;
    _addNewTodoState.selectedDate = widget.todos.date;
  }

  bool get todoUpdate =>
      _titleController.text.isNotEmpty ||
      _descriptionController.text.isNotEmpty ||
      _addNewTodoState.selectedDate != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Update title',
                contentPadding: EdgeInsets.all(8),
              ),
              controller: _titleController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {},
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Update description',
                contentPadding: EdgeInsets.all(8),
              ),
              controller: _descriptionController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {},
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Observer(
                      builder: (_) => Text(
                        _addNewTodoState.selectedDate == null
                            ? 'No date Chosen!'
                            : 'Picked date ${DateFormat.yMd().format(_addNewTodoState.selectedDate!)}',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _presentDatePicker(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (todoUpdate) {
                          Navigator.pop(
                            context,
                            TodoModel(
                              id: widget.todos.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: _addNewTodoState.selectedDate ?? DateTime.now(),
                              done: widget.todos.done,
                            ),
                          );
                        } else {
                          _addNewTodoState.errorMessage = 'has required fields';
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text('Update Todo'),
                    ),
                  ),
                ],
              ),
            ),
            Observer(
              builder: (_) => _addNewTodoState.errorMessage != null
                  ? Text(_addNewTodoState.errorMessage!)
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    ).then(
      (pickedData) {
        if (pickedData == null) {
          return;
        }
        _addNewTodoState.selectedDate = pickedData;
      },
    );
  }
}
