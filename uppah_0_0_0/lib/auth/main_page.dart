import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uppah_0_0_0/pages/home_page.dart';
import 'package:uppah_0_0_0/pages/login_page.dart';

import 'verifyEmail_page.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmailPage();
            /* return HomePage(); */
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
