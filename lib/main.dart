import 'package:flutter/material.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';
import 'package:guitar_mentor/src/pages/home/start_page.dart';
import 'package:guitar_mentor/src/pages/my_home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuitarMentor',
      theme: ThemeData(
        focusColor: ThemeColors.primaryColor,
        primaryColor: ThemeColors.primaryColor,
        scaffoldBackgroundColor: ThemeColors.scaffoldBbColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ThemeColors.primaryColor, // Aquí cambias el color del cursor de texto
          selectionColor: ThemeColors.primaryColor.withOpacity(0.5), // Color de selección de texto
          selectionHandleColor: ThemeColors.primaryColor, // Color del manejador de selección
        ),
        
      ),

      home: StartPage(),
    );
  }
}
