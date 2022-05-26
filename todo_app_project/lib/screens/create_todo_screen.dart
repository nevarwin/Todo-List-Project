import 'package:flutter/material.dart';

class CreateTodoScreen extends StatelessWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  static const routeName = './createTodoScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo Screen'),
      ),
      body: Center(
        child: Text('Create Todo List'),
      ),
    );
  }
}
