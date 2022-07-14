import 'package:flutter/material.dart';

enum Importance {
  low,
  medium,
  high,
}

enum Label {
  todo,
  doing,
  done,
}

class Todo {
  final String id;
  final String title;
  final Importance importance;
  final Label label;

  Todo({
    required this.id,
    required this.title,
    required this.importance,
    required this.label,
  });
}
