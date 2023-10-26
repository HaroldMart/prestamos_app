import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prestamos_app/auth/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
        fontFamily: 'Poppins'
      ),
    );
  }
}
