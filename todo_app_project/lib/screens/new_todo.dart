import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:todo_app_project/provider/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  DateTime? _choosenDate;
  var _showDetails = false;

  @override
  void didChangeDependencies() {
    final todoData = Provider.of<TodoProvider>(context);
    super.didChangeDependencies();
  }

  void _setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  void _save() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
              validator: (value) {
                if (value == '') {
                  return 'Add a task';
                }
                return null;
              },
            ),
            if (_showDetails)
              TextFormField(
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Details',
                ),
              ),
            Row(
              children: [
                IconButton(
                  color: _showDetails
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  onPressed: () {
                    setState(() {
                      _showDetails = !_showDetails;
                    });
                  },
                  icon: const Icon(Icons.menu),
                ),
                IconButton(
                  onPressed: _setDate,
                  icon: const Icon(Icons.calendar_today),
                ),
                if (_choosenDate != null)
                  TextButton.icon(
                    onPressed: () {},
                    label: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                    icon: Text(
                      DateFormat.MMMEd().format(_choosenDate!),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: _save,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
