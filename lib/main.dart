import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/screens/welcome.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => InfoProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
