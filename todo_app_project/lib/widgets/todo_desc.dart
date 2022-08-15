import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoDesc extends StatelessWidget {
  TodoDesc({
    Key? key,
    required this.title,
    required this.date,
    required this.importance,
    required this.label,
  }) : super(key: key);

  final String title;
  Importance importance;
  Label label;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        ChoiceChip(label: Text(importance.name), selected: false),
        ChoiceChip(label: Text(label.name), selected: false),
        Text(
          DateFormat.yMEd().format(date),
        ),
      ],
    );
  }
}
