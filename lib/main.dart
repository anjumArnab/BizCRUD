import 'package:google_fonts/google_fonts.dart';
import 'package:restapi_crud/screen/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Info CRUD',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const HomePage(),
    );
  }
}