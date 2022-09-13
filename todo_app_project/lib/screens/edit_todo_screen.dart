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
  var _isLoading = false;

  Todo _todoTemplate = Todo(
    title: null,
    description: null,
    date: null,
  );

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
          _todoTemplate.date = DateFormat.MMMEd().format(pickedDate).toString();
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _todo = ModalRoute.of(context)!.settings.arguments as Todo;

    // datelabel is 'add date' text
    if (_choosenDate == null && _todo.date == null) {
      dateLabel;
      // checking if the user selected new date then it will be displayed
    } else if (_choosenDate != null) {
      dateLabel = DateFormat.MMMEd().format(_choosenDate!);
      // if saved without picking a new date.
      // It must be remained to be the first date selected.
    } else {
      dateLabel = _todo.date!;
    }

    if (_choosenDate == null) {
      _todoTemplate.date = _todo.date;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await context.read<TodoProvider>().removeTodo(
                      _todo.id!,
                    );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Deleted'),
                    duration: Duration(seconds: 1),
                  ),
                );
              } catch (error) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Deletion Failed'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_rounded),
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });

              _formGlobalKey.currentState?.save();

              await context.read<TodoProvider>().updateTodo(
                    _todo.id!,
                    _todoTemplate,
                    // _choosenDate ?? _todo.date,
                  );
              setState(() {
                _isLoading = false;
              });
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
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
                          date: _todoTemplate.date,
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
                                    date: _todoTemplate.date,
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
                      child: Row(
                        children: [
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
                                dateLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          if (_todo.date != null ||
                              _choosenDate != null ||
                              _todoTemplate.date != null)
                            CloseButton(
                              onPressed: () {
                                setState(() {
                                  dateLabel = 'Add date';
                                  _todo.date = null;
                                  _choosenDate = null;
                                  _todoTemplate.date = null;
                                });
                              },
                              color: Theme.of(context).errorColor,
                            )
                        ],
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
