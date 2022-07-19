import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
    required this.allTodos,
  }) : super(key: key);

  final List<Todo> allTodos;

  @override
  Widget build(BuildContext context) {
    return allTodos.isEmpty
        ? const Center(
            child: Text('No todos'),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: allTodos.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    color: Colors.blueGrey[50],
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(allTodos[index].title),
                          Chip(
                            label: Text(
                              allTodos[index].importance.toString(),
                            ),
                          ),
                          Chip(
                            label: Text(
                              allTodos[index].label.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
