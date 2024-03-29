import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_project/screens/edit_todo_screen.dart';

import '../provider/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      context.read<TodoProvider>().fetchTodoData().then(
            (_) => setState(() {
              _isLoading = false;
            }),
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
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
                    onDismissed: (direction) async {
                      try {
                        await todoData.removeTodo(_item);
                        scaffold.hideCurrentMaterialBanner();
                        scaffold.showSnackBar(
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
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      } catch (error) {
                        scaffold.hideCurrentMaterialBanner();
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.note,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text('Deletion Failed'),
                              ],
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _todos.checkboxValue
                              ? null
                              : Navigator.of(context).pushNamed(
                                  EditTodoScreen.routeName,
                                  arguments: _todos,
                                );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: Theme.of(context).colorScheme.primary,
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
                                    if (_todos.title != null)
                                      Text(
                                        _todos.title!,
                                        style: _todos.checkboxValue
                                            ? const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                              )
                                            : const TextStyle(
                                                decoration: TextDecoration.none,
                                              ),
                                      ),
                                    if (_todos.description != null)
                                      Text(
                                        _todos.description!,
                                        style: _todos.checkboxValue
                                            ? const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                              )
                                            : const TextStyle(
                                                decoration: TextDecoration.none,
                                              ),
                                      ),
                                    if (_todos.date != null)
                                      Text(
                                        _todos.date!,
                                        style: _todos.checkboxValue
                                            ? const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                              )
                                            : const TextStyle(
                                                decoration: TextDecoration.none,
                                              ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            // Text(_todos.id!),
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
