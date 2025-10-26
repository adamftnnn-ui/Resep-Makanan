import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/main_controller.dart';
import 'views/splash_screen.dart'; // import splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resep App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF4CAF50),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(), // ganti MainController -> SplashScreen
    );
  }
}
