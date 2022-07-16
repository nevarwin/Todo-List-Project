import 'package:flutter/material.dart';
import 'package:todo_app_project/widgets/todo_list.dart';

import '../models/todo.dart';
import '../widgets/new_todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Todo> _todos = [];

    void _addTodo({
      required String id,
      required String title,
      required Importance importance,
      required Label label,
      required DateTime date,
    }) {
      final newTodo = Todo(
        id: id,
        title: title,
        importance: importance,
        label: label,
        date: date,
      );
      setState(() {
        _todos.add(newTodo);
      });
    }

    void _showModal() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTodo(
              addTodo: _addTodo,
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TodoList(
                allTodos: _todos,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _showModal,
        ),
      ),
    );
  }
}
