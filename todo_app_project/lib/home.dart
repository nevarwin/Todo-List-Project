import 'package:flutter/material.dart';

import './screens/todo_screen.dart';
import './screens/doing_screen.dart';
import './screens/done_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPages(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return TodoScreen();
      case 1:
        return DoingScreen();
      case 2:
        return DoneScreen();
      default:
        return Container(
          color: Colors.black54,
        );
    }
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          this.index = index;
        });
      },
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          label: 'Todo',
          icon: Icon(Icons.today),
        ),
        BottomNavigationBarItem(
          label: 'Doing',
          icon: Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          label: 'Done',
          icon: Icon(Icons.check),
        ),
      ],
    );
  }
}
