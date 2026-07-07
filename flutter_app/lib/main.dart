import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'core/api/api_client.dart';




void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await ApiClient.initialize();

  runApp(
    const FarmApp(),
  );
}

class FarmApp extends StatelessWidget {
  const FarmApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}