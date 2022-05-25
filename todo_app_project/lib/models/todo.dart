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
