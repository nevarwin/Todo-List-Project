import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/todo.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-todo';

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _sizedboxWidth = 8.0;
  DateTime? _choosenDate;
  var dateLabel = 'Add date';

  void _setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _choosenDate = pickedDate;
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _todo = ModalRoute.of(context)!.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _todo.title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.menu_rounded,
                ),
                SizedBox(
                  width: _sizedboxWidth,
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: _todo.description ?? '',
                    decoration: const InputDecoration(
                      hintText: 'Add details',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: _setDate,
              icon: const Icon(
                Icons.edit_calendar,
                color: Colors.black87,
              ),
              label: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _todo.date == null
                      ? dateLabel
                      : DateFormat.MMMEd().format(_todo.date!),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
