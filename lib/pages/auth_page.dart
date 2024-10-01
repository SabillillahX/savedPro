import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        // user login
        if (snapshot.hasData) {
          return HomePage();
        }

        // user NOT login
        else {
          return const LoginOrRegisterPage();
        }
      },
    ));
  }
}
