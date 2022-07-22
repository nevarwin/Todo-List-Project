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
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  color: Colors.blueGrey[50],
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(allTodos[index].title),
                        Row(
                          children: [
                            if (Importance.low == allTodos[index].importance)
                              const Text('Low'),
                            if (Importance.medium == allTodos[index].importance)
                              const Text('Medium'),
                            if (Importance.high == allTodos[index].importance)
                              const Text('High'),
                            const SizedBox(width: 10),
                            Chip(
                              label: Text(
                                allTodos[index].label.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
