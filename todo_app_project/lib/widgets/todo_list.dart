import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    Key? key,
    required this.allTodos,
  }) : super(key: key);

  final List<Todo> allTodos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return widget.allTodos.isEmpty
        ? const Center(
            child: Text('No todos'),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: widget.allTodos.length,
              itemBuilder: ((context, index) {
                final _item = widget.allTodos[index].id;
                return Dismissible(
                  key: Key(_item),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).errorColor,
                  ),
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${widget.allTodos[index].title} dismissed'),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                    setState(() {
                      widget.allTodos.removeAt(index);
                    });
                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.blueGrey[50],
                    child: ListTile(
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Chip(
                                label: Text(
                                    widget.allTodos[index].importance.name),
                                backgroundColor:
                                    const Color.fromRGBO(255, 182, 115, 1),
                              ),
                              const SizedBox(width: 6),
                              Chip(
                                label: Text(widget.allTodos[index].label.name),
                                backgroundColor:
                                    const Color.fromRGBO(255, 182, 115, 1),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.allTodos[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.yMEd()
                                    .format(widget.allTodos[index].date),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
