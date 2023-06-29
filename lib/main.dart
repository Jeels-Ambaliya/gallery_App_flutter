import 'package:flutter/material.dart';
import 'package:gallery_app/Controller/Provider/category_Provider.dart';
import 'package:gallery_app/Controller/Provider/theme_Provider.dart';
import 'package:gallery_app/Views/Screens/Splash_Screen.dart';
import 'package:gallery_app/Views/Screens/view_Screen.dart';
import 'package:provider/provider.dart';

import 'Views/Screens/Home_Screen.dart';

void main() {
  runApp(
    const My_App(),
  );
}

class My_App extends StatefulWidget {
  const My_App({Key? key}) : super(key: key);

  @override
  State<My_App> createState() => _My_AppState();
}

class _My_AppState extends State<My_App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          initialRoute: 'Splash_Screen',
          routes: {
            'Splash_Screen': (context) => const Splash_Screen(),
            'Home_Screen': (context) => const Home_Screen(),
            'View_Screen': (context) => const View_Screen(),
          },
        );
      },
    );
  }
}
