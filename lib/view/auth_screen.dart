import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tweetapp/controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authCtrlr = Get.put(AuthController());
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Signin with your Google Account'),
            const SizedBox(height: 20),
            FilledButton(
                onPressed: () async {
                  await authCtrlr.signIn();
                },
                child: const Text('Authenticate'))
          ],
        ),
      ),
    ));
  }
}
