import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  final String? id;
  final String? title;
  final String? description;
  final Importance importance;
  final Label label;
  DateTime? date;
  bool checkboxValue;

  Todo({
    this.id,
    this.title,
    this.description,
    this.importance = Importance.low,
    this.label = Label.todo,
    this.date,
    this.checkboxValue = false,
  });
}

class TodoProvider with ChangeNotifier {
  var uuid = const Uuid().v1();

  final List<Todo> _todoList = [
    Todo(
      id: 'id1',
      title: 'Title',
      // description: 'Description',
      // date: DateTime.now(),
    ),
  ];

  List<Todo> get getTodoList {
    return [..._todoList];
  }

  void findById(String id) {
    _todoList.firstWhere((todo) => todo.id == id);
  }

  Future<void> addNewTodo(
    Todo todo,
    DateTime? date,
  ) async {
    final url = Uri.https(
      'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/todos.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
          'date': date!.toIso8601String(),
        }),
      );

      _todoList.insert(
        0,
        Todo(
          id: json.decode(response.body)['name'],
          title: todo.title,
          description: todo.description,
          date: date,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void updateTodo(
    String id,
    Todo existingTodo,
    DateTime? date,
  ) {
    final todoIndex = _todoList.indexWhere((element) => element.id == id);

    if (todoIndex >= 0) {
      _todoList[todoIndex] = existingTodo;
      _todoList[todoIndex].date = date;
    }
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
