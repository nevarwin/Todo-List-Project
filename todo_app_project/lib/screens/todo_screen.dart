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
  final List<Todo> _todoMap = [
      // Todo(
      //   id: DateTime.now().toString(),
      //   title: 'Title1',
      //   date: DateTime.now(),
      // )
    ];

    void _addNewTodo(
      String addtitle,
      Importance addimportance,
      Label addlabel,
      DateTime adddate,
    ) {
      final newTodo = Todo(
        id: DateTime.now().toString(),
        title: addtitle,
        importance: addimportance,
        label: addlabel,
        date: adddate,
      );

      setState(() {
        _todoMap.add(newTodo);
        print('submitted');
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
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            TodoList(
              allTodos: _todoMap,
            ),
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
