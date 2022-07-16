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
    final List<Todo> _todoMap = [];

    void _addNewTodo(
      String title,
      Importance importance,
      Label label,
      DateTime date,
    ) {
      final newTodo = Todo(
        id: DateTime.now().toIso8601String(),
        title: title,
        importance: importance,
        label: label,
        date: date,
      );

      setState(() {
        _todoMap.add(newTodo);
        print(_todoMap);
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
              addTodo: _addNewTodo,
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
                allTodos: _todoMap,
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
