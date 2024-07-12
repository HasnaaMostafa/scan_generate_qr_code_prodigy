import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/features/introduction/presentation/views/intro_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffd14909),
              primary: const Color(0xffd14909))),
      debugShowCheckedModeBanner: false,
      home: IntroView(),
    );
  }
}
