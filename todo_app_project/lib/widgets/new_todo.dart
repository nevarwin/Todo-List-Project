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
  Importance _importance = Importance.low;
  Label _label = Label.todo;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Widget _buildChipTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildImportanceChip({
    required String chipTitle,
    var chipVar,
    required Importance importanceChip,
  }) {
    return ChoiceChip(
      selectedColor: const Color.fromRGBO(255, 182, 115, 1),
      label: Text(chipTitle),
      selected: chipVar == importanceChip,
      onSelected: (selected) {
        setState(() {
          _importance = importanceChip;
        });
      },
    );
  }

  Widget _buildLabelChip({
    String? chipTitle,
    var chipVar,
    Label? labelChip,
  }) {
    return ChoiceChip(
      selectedColor: const Color.fromRGBO(255, 182, 115, 1),
      label: Text(chipTitle!),
      selected: chipVar == labelChip,
      onSelected: (selected) {
        setState(() {
          _label = labelChip!;
        });
      },
    );
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
    if (_choosenDate == null) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text('Alert'),
              ],
            ),
            content: const Text('Please pick a date.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop();
                },
              )
            ],
          );
        },
      );
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
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChipTitle('Importance'),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        _buildImportanceChip(
                          chipTitle: 'Low',
                          chipVar: _importance,
                          importanceChip: Importance.low,
                        ),
                        _buildImportanceChip(
                          chipTitle: 'Medium',
                          chipVar: _importance,
                          importanceChip: Importance.medium,
                        ),
                        _buildImportanceChip(
                          chipTitle: 'High',
                          chipVar: _importance,
                          importanceChip: Importance.high,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChipTitle('Label'),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        _buildLabelChip(
                          chipTitle: 'Todo',
                          chipVar: _label,
                          labelChip: Label.todo,
                        ),
                        _buildLabelChip(
                          chipTitle: 'Doing',
                          chipVar: _label,
                          labelChip: Label.doing,
                        ),
                        _buildLabelChip(
                          chipTitle: 'Done',
                          chipVar: _label,
                          labelChip: Label.done,
                        ),
                      ],
                    ),
                  ],
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
