import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/Business_providers.dart';
import '../screen/homepage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BusinessProvider(),
      child: const BizCRUD(),
    ),
  );
}

class BizCRUD extends StatelessWidget {
  const BizCRUD({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BizCRUD',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const HomePage(),
    );
  }
}
