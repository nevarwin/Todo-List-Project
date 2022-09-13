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
  final _formKey = GlobalKey<FormState>();
  DateTime? _choosenDate;
  var _showDetails = false;
  var _isLoading = false;
  final _detailsFocusNode = FocusNode();

  Todo todoTemplate = Todo(
    id: null,
    title: '',
    date: null,
    description: null,
  );

  @override
  void dispose() {
    _detailsFocusNode.dispose();
    super.dispose();
  }

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
          todoTemplate.date = DateFormat.MMMEd().format(pickedDate).toString();
        });
      }
      return;
    });
  }

  Future<void> _save() async {
    final _isValid = _formKey.currentState!.validate();

    if (!_isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<TodoProvider>().addNewTodo(
            todoTemplate,
          );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('An error occured!'),
            content: Text('Something went wrong $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
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
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Task',
                    ),
                    onSaved: (newValue) {
                      todoTemplate = Todo(
                        title: newValue,
                        description: todoTemplate.description,
                        date: todoTemplate.date,
                      );
                    },
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
                        hintText: 'Details',
                      ),
                      focusNode: _detailsFocusNode,
                      onSaved: (newValue) {
                        todoTemplate = Todo(
                          title: todoTemplate.title,
                          description: newValue,
                          date: todoTemplate.date,
                        );
                      },
                    ),
                  Row(
                    children: [
                      IconButton(
                        color: _showDetails
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(
                              _detailsFocusNode,
                            );
                            _showDetails = !_showDetails;
                          });
                        },
                        icon: const Icon(
                          Icons.menu_rounded,
                        ),
                      ),
                      IconButton(
                        onPressed: _setDate,
                        icon: const Icon(Icons.calendar_today),
                      ),
                      if (_choosenDate != null)
                        Row(
                          children: [
                            Text(
                              DateFormat.MMMEd().format(_choosenDate!),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            CloseButton(
                              onPressed: () {
                                setState(() {
                                  _choosenDate = null;
                                  todoTemplate.date = null;
                                });
                              },
                              color: Theme.of(context).errorColor,
                            )
                          ],
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
