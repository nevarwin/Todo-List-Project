import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_project/screens/edit_todo_screen.dart';

import '../provider/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<TodoProvider>(context);

    final allTodos = todoData.getTodoList;

    const String assetName = 'assets/addtodo.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      semanticsLabel: 'Add Todo',
    );

    return allTodos.isEmpty
        ? Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: svg,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add Todo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: allTodos.length,
                itemBuilder: (context, index) {
                  final _item = allTodos[index].id;
                  final _todos = allTodos[index];
                  return Dismissible(
                    key: Key(_item!),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.all(4.0),
                      child: const Icon(
                        Icons.delete,
                        size: 35,
                        color: Colors.white,
                      ),
                      color: Theme.of(context).errorColor,
                    ),
                    onDismissed: (direction) {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(
                                Icons.note,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text('${_todos.title} dismissed'),
                            ],
                          ),
                          duration: const Duration(days: 1),
                        ),
                      );
                      todoData.removeTodo(_todos.id!);
                    },
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            EditTodoScreen.routeName,
                            arguments: _todos.id,
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: Colors.blue,
                              value: _todos.checkboxValue,
                              onChanged: (value) {
                                setState(() {
                                  _todos.checkboxValue = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_todos.title),
                                    if (_todos.description != null)
                                      Text(
                                        _todos.description!,
                                      ),
                                    if (_todos.date != null)
                                      Text(
                                        DateFormat.MMMEd().format(_todos.date!),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
