import 'package:flutter/material.dart';
import 'package:ict_flex_app/views/index_view.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'ICT-Flex App',
            theme: ThemeData(
                brightness: Brightness.light,
                useMaterial3: true,
                textTheme: const TextTheme(
                    labelMedium: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ),
            darkTheme: ThemeData(
                brightness: Brightness.light,
                useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            home: const IndexView(),
        );
    }
}
