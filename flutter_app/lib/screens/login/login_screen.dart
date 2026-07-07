import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShivShakti Farm Manager',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

  final success =
      await AuthService().login(

    usernameController.text,

    passwordController.text,

  );

  if (!mounted) return;

  if (success) {

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const DashboardScreen(),
  ),
);

  } else {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text("Invalid Credentials"),

      ),

    );

  }

},
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}