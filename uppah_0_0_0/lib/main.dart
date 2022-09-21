import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uppah_0_0_0/pages/home_page.dart';
import 'package:uppah_0_0_0/pages/login_page.dart';

import 'auth/main_page.dart';

/* void main() => runApp(const MyApp()); */

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(useMaterial3: true),
      home: MainPage(),
    );
  }
}
