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
  String? date;
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
  final url = Uri.https(
    'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/todos.json',
  );

  List<Todo> _todoList = [
    // Todo(
    //   id: 'id1',
    //   title: 'Title',
    //   // description: 'Description',
    //   // date: DateTime.now(),
    // ),
  ];

  List<Todo> get getTodoList {
    return [..._todoList];
  }

  void findById(String id) {
    _todoList.firstWhere((todo) => todo.id == id);
  }

  // TODO: nullable
  Future<void> fetchTodoData() async {
    try {
      final response = await http.get(url);
      final todoFetchedData =
          json.decode(response.body) as Map<String, dynamic>;

      if (todoFetchedData.isEmpty) {
        return;
      }

      final List<Todo> emptyList = [];

      todoFetchedData.forEach((todoId, todoData) {
        // DateTime? dateData = todoData['date'];

        emptyList.insert(
          0,
          Todo(
            id: todoId,
            title: todoData['title'],
            description: todoData['description'],
            date: todoData['date'],
          ),
        );
      });
      _todoList = emptyList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addNewTodo(
    Todo todo,
    // DateTime? date,
  ) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
          // 'date': DateFormat('EEEE d MMM hh:mm:ss').format(todo.date!),
          'date': todo.date,
        }),
      );

      _todoList.insert(
        0,
        Todo(
          id: json.decode(response.body)['name'],
          title: todo.title,
          description: todo.description,
          date: todo.date,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateTodo(
    String id,
    Todo existingTodo,
  ) async {
    final todoIndex = _todoList.indexWhere((element) => element.id == id);

    final url = Uri.https(
      'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/todos/$id.json',
    );
    if (todoIndex >= 0) {
      await http.patch(
        url,
        body: json.encode({
          'title': existingTodo.title,
          'description': existingTodo.description,
          'date': existingTodo.date,
        }),
      );

      _todoList[todoIndex] = existingTodo;
      // _todoList[todoIndex].date = date;
      notifyListeners();
    }
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
