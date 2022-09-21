import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_project/screens/authentication_screen.dart';

import '../provider/todo.dart';
import '../provider/auth.dart';
import './screens/todo_screen.dart';
import './screens/edit_todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: FlexThemeData.light(
        scheme: FlexScheme.shark,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
          textButtonSchemeColor: SchemeColor.tertiary,
          outlinedButtonSchemeColor: SchemeColor.secondary,
          fabSchemeColor: SchemeColor.secondaryContainer,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use the playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.shark,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          textButtonSchemeColor: SchemeColor.tertiary,
          outlinedButtonSchemeColor: SchemeColor.secondary,
          fabSchemeColor: SchemeColor.secondaryContainer,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use the playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      // If you do not have a themeMode switch, uncomment this line
      // to let the device system mode control the theme mode:
      themeMode: ThemeMode.system,

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),

        // TODO: Bug

        ProxyProvider<AuthProvider, TodoProvider>(
          update: (context, value, previous) => TodoProvider(
            value.token,
            previous == null ? [] : previous.getTodoList,
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Consumer<AuthProvider>(
          builder: (context, authValue, _) {
            return MaterialApp(
              // initialRoute: const AuthenticationScreen(),
              home: authValue.isAuth ? const TodoScreen() : const AuthenticationScreen(),
              routes: {
                TodoScreen.routeName: (context) => const TodoScreen(),
                EditTodoScreen.routeName: (context) => const EditTodoScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
