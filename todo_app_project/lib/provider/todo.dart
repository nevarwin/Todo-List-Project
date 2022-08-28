import 'package:flutter/cupertino.dart';

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
  final DateTime date;

  Todo({
    required this.id,
    required this.title,
    this.importance = Importance.low,
    this.label = Label.todo,
    required this.date,
  });
}

class TodoProvider with ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get getTodoList {
    return [..._todoList];
  }

  void addNewTodo(
    String title,
    Importance importance,
    Label label,
    DateTime date,
  ) {
    _todoList.insert(
      0,
      Todo(
        id: DateTime.now().toString(),
        title: title,
        date: date,
      ),
    );
    notifyListeners();
  }

  void removeTodo(String id) {
    _todoList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
