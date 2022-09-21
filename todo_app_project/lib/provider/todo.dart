import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_project/provider/http_exception.dart';

class Todo {
  final String? id;
  final String? title;
  final String? description;
  String? date;
  bool checkboxValue;

  Todo({
    this.id,
    this.title,
    this.description,
    this.date,
    this.checkboxValue = false,
  });
}

class TodoProvider with ChangeNotifier {
  List<Todo> _todoList = [];
  final String authToken;

  // TODO: Review
  TodoProvider(
    this.authToken,
    this._todoList,
  );

  List<Todo> get getTodoList {
    return [..._todoList];
  }

  void findById(String id) {
    _todoList.firstWhere((todo) => todo.id == id);
  }

  Future<void> fetchTodoData() async {
    final url = Uri.https(
      'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/todos.json?auth=$authToken',
    );
    try {
      final response = await http.get(url);
      final todoFetchedData = json.decode(response.body) as Map<String, dynamic>;

      if (todoFetchedData.isEmpty) {
        return;
      }

      final List<Todo> emptyList = [];

      todoFetchedData.forEach((todoId, todoData) {
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
  ) async {
    final url = Uri.https(
      'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/todos.json?auth=$authToken',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
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

  Future<void> removeTodo(String id) async {
    final url = Uri.https(
      'todoproject-4ce81-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/todos/$id.json',
    );
    final todoIndex = _todoList.indexWhere((todo) => todo.id == id);
    Todo? todoItems = _todoList[todoIndex];

    _todoList.removeAt(todoIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _todoList.insert(todoIndex, todoItems);
      notifyListeners();
      throw HttpException('An error occured');
    }
    todoItems = null;
  }
}
