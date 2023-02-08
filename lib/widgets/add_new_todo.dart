import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

import '../store/todo_home_state/add_new_todo_state/add_new_todo_state.dart';

class AddNewTodo extends StatefulWidget {
  const AddNewTodo({
    super.key,
  });

  @override
  State<AddNewTodo> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodo> {
  final _addNewTodoState = AddNewTodoState();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool get todoCreated =>
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty &&
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
                labelText: 'Add title',
                contentPadding: EdgeInsets.all(8),
              ),
              controller: _titleController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _titleController.clear();
                _descriptionController.clear();
              },
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Add description',
                contentPadding: EdgeInsets.all(8),
              ),
              controller: _descriptionController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _titleController.clear();
                _descriptionController.clear();
              },
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
            ElevatedButton(
              onPressed: () {
                if (todoCreated) {
                  Navigator.pop(
                    context,
                    TodoModel(
                      id: const Uuid().v4(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _addNewTodoState.selectedDate!,
                      done: false,
                    ),
                  );
                } else {
                  _addNewTodoState.errorMessage = 'has required fields';
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text('Add Todo'),
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
