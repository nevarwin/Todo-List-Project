import 'package:flutter/material.dart';

import './screens/todo_screen.dart';
import './screens/edit_todo_screen.dart';
import 'package:todo_app_project/screens/todo_desc_screen.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 182, 115, .1),
  100: const Color.fromRGBO(255, 182, 115, .2),
  200: const Color.fromRGBO(255, 182, 115, .3),
  300: const Color.fromRGBO(255, 182, 115, .4),
  400: const Color.fromRGBO(255, 182, 115, .5),
  500: const Color.fromRGBO(255, 182, 115, .6),
  600: const Color.fromRGBO(255, 182, 115, .7),
  700: const Color.fromRGBO(255, 182, 115, .8),
  800: const Color.fromRGBO(255, 182, 115, .9),
  900: const Color.fromRGBO(255, 182, 115, 1),
};
MaterialColor colorCustom = MaterialColor(0xFFFF03, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: colorCustom,
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(255, 182, 115, 1),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          splashColor: Color.fromRGBO(255, 182, 115, 1),
          backgroundColor: Color.fromRGBO(255, 182, 115, 1),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const TodoScreen(),
          TodoDescScreen.routeName: (context) => TodoDescScreen(),
          EditTodoScreen.routeName: (context) => EditTodoScreen(),
        },
      ),
    );
  }
}
