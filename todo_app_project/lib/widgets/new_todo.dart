import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app_project/provider/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({
    Key? key,
    required this.addTodo,
  }) : super(key: key);

  final Function addTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final titleController = TextEditingController();

  DateTime? _choosenDate;
  final Importance _importance = Importance.low;
  final Label _label = Label.todo;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
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

  void _submit() {
    final tCtrl = titleController.text;

    if (tCtrl == '') {
      return;
    }

    widget.addTodo(
      tCtrl,
      _importance,
      _label,
      _choosenDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Container(
        color: Colors.blueGrey[50],
        padding: EdgeInsets.only(
          top: 0,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  // Todo
                  textCapitalization: TextCapitalization.sentences,
                  enableSuggestions: false,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        titleController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    labelText: 'New Task',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    value = titleController.text;
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _setDate,
                      icon: const Icon(
                        Icons.date_range_outlined,
                        color: Color.fromRGBO(255, 182, 115, 1),
                      ),
                    ),
                    Text(
                      _choosenDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMEd().format(_choosenDate!),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: _submit,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
