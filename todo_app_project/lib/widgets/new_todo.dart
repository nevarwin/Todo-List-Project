import 'package:flutter/material.dart';
import 'package:todo_app_project/models/todo.dart';

class NewTodo extends StatefulWidget {
  NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final titleController = TextEditingController();

  var _importance = Importance.low;
  var _label = Label.todo;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
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
