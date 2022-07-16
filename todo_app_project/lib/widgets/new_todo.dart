import 'package:flutter/material.dart';
import 'package:todo_app_project/models/todo.dart';

class NewTodo extends StatefulWidget {
  NewTodo({
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
  var _importance = Importance.low;
  var _label = Label.todo;

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
    String? chipTitle,
    var chipVar,
    Importance? importanceChip,
  }) {
    return ChoiceChip(
      selectedColor: const Color.fromRGBO(255, 182, 115, 1),
      label: Text(chipTitle!),
      selected: chipVar == importanceChip,
      onSelected: (selected) {
        setState(() {
          _importance = importanceChip!;
          print(_importance);
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
          print(_label);
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
    final date = _choosenDate.toString();

    if (tCtrl == '' && date == '') {
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.blueGrey[50],
          padding: MediaQuery.of(context).viewInsets,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'New Task',
                      labelStyle: TextStyle(
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
                  IconButton(
                    onPressed: _setDate,
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Color.fromRGBO(255, 182, 115, 1),
                    ),
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
      ),
    );
  }
}
