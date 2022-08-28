import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todo.dart';
import '../widgets/new_todo.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<TodoProvider>(context);

    void _showModal() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTodo(
              addTodo: todoData.addNewTodo,
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
          actions: [
            IconButton(
              onPressed: _showModal,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: const [
            TodoList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _showModal,
        ),
      ),
    );
  }
}
