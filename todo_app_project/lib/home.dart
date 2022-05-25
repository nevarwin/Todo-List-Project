import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
