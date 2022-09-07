import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/todo.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-todo';

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _sizedboxWidth = 8.0;
  DateTime? _choosenDate;
  var dateLabel = 'Add date';

  Todo _todoTemplate = Todo(
    title: null,
    description: null,
  );

  void _setDate() {
    debugPrint('trigger setdate');
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

    if (_choosenDate == null && _todo.date == null) {
      dateLabel;
    } else if (_choosenDate != null) {
      dateLabel = DateFormat.MMMEd().format(_choosenDate!);
    } else {
      dateLabel = DateFormat.MMMEd().format(_todo.date!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            onPressed: () {
              _formGlobalKey.currentState?.save();

              context.read<TodoProvider>().updateTodo(
                    _todo.id!,
                    _todoTemplate,
                    _choosenDate ?? _todo.date,
                  );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successful'),
                  duration: Duration(seconds: 1),
                ),
              );

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: Form(
        key: _formGlobalKey,
        child: Padding(
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
                onSaved: (newValue) {
                  _todoTemplate = Todo(
                    id: _todo.id,
                    title: newValue,
                    description: _todoTemplate.description,
                    date: _todo.date,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu_rounded,
                    ),
                    SizedBox(
                      width: _sizedboxWidth,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _todo.description,
                        decoration: const InputDecoration(
                          hintText: 'Add details',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onSaved: (newValue) {
                          if (newValue != '') {
                            _todoTemplate = Todo(
                              id: _todo.id,
                              title: _todoTemplate.title,
                              description: newValue,
                              date: _todo.date,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton.icon(
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
                      dateLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   String buildText() {
//     if (_choosenDate != null) {
//       setState(() {});
//     }
//     return 'Add date';
//   }
}
