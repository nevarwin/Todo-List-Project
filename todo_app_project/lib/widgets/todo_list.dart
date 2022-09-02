import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    return Dismissible(
                      key: Key(_item),
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
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.note,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text('${allTodos[index].title} dismissed'),
                              ],
                            ),
                            duration: const Duration(days: 1),
                          ),
                        );
                        todoData.removeTodo(allTodos[index].id);
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
                                    label:
                                        Text(allTodos[index].importance.name),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 182, 115, 1),
                                  ),
                                  const SizedBox(width: 6),
                                  Chip(
                                    label: Text(allTodos[index].label.name),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 182, 115, 1),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    allTodos[index].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMEd()
                                        .format(allTodos[index].date!),
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
