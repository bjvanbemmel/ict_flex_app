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
                useMaterial3: true,
                brightness: Brightness.light,
                primaryColor: Colors.orange.shade700,
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.grey.shade100,
                    scrolledUnderElevation: 0.0,
                ),
                tooltipTheme: TooltipThemeData(
                    textStyle: const TextStyle(
                        color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade600.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                ),
                snackBarTheme: SnackBarThemeData(
                    backgroundColor: Colors.grey.shade300,
                ),
                textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.orange.shade700,
                    selectionColor: Colors.orange.shade700,
                    selectionHandleColor: Colors.orange.shade700,
                ),
                textTheme: const TextTheme(
                    labelLarge: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                    ),
                    labelMedium: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                    ),
                    labelSmall: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                    ),
                ),
            ),
            darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                primaryColor: Colors.orange.shade700,
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.grey.shade900,
                    scrolledUnderElevation: 0.0,
                ),
                tooltipTheme: TooltipThemeData(
                    textStyle: const TextStyle(
                        color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                ),
                snackBarTheme: SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                ),
                textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.orange.shade700,
                    selectionColor: Colors.orange.shade700,
                    selectionHandleColor: Colors.orange.shade700,
                ),
                textTheme: const TextTheme(
                    labelLarge: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                    ),
                    labelMedium: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                    ),
                    labelSmall: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                    ),
                ),
            ),
            themeMode: ThemeMode.system,
            home: const IndexView(),
        );
    }
}
