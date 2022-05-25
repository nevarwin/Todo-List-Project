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
  String title;
  Importance importance;
  Label label;

  Todo(
    this.title,
    this.importance,
    this.label,
  );
}

final allTodos = [
  Todo(
    'Task1',
    Importance.low,
    Label.todo,
  ),
  Todo(
    'Task2',
    Importance.medium,
    Label.doing,
  ),
  Todo(
    'Task2',
    Importance.high,
    Label.done,
  ),
];
