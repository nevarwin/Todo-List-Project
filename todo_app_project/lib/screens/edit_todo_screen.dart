import 'package:flutter/material.dart';

import '../widgets/new_todo.dart';
import 'package:todo_app_project/widgets/edit_todo.dart';
import '../models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({Key? key}) : super(key: key);

  static const routeName = '/editTodoScreen';

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  // void _addNewTodo(
  //   String addtitle,
  //   Importance addimportance,
  //   Label addlabel,
  //   DateTime adddate,
  // ) {
  //   final newTodo = Todo(
  //     id: DateTime.now().toString(),
  //     title: addtitle,
  //     importance: addimportance,
  //     label: addlabel,
  //     date: adddate,
  //   );

  //   setState(() {
  //     todoMap.add(newTodo);
  //     print('submitted');
  //   });
  // }

  // void _showModal(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (_) {
  //       return GestureDetector(
  //         behavior: HitTestBehavior.opaque,
  //         onTap: () {},
  //         child: NewTodo(
  //           addTodo: _addNewTodo,
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Todo;

    void _editTodo(
      String addtitle,
      Importance addimportance,
      Label addlabel,
      DateTime adddate,
    ) {
      final newTodo = Todo(
        id: args.id,
        title: addtitle,
        importance: addimportance,
        label: addlabel,
        date: adddate,
      );

      setState(() {
        todoMap.contains(element);
        print('edited');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: EditTodo(editTodo: _editTodo),
    );
  }
}
