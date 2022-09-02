import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

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
  final DateTime? date;

  Todo({
    required this.id,
    required this.title,
    this.importance = Importance.low,
    this.label = Label.todo,
    this.date,
  });
}

class TodoProvider with ChangeNotifier {
  var uuid = const Uuid().v1();
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
        id: uuid,
        title: title,
        date: date,
      ),
    );
    notifyListeners();
  }

  void undo(int index) {
    _todoList.insert(
      index,
      _todoList.removeAt(index),
    );
    notifyListeners();
  }

  void removeTodo(String id) {
    _todoList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
