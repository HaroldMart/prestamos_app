import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prestamos_app/auth/auth.dart';
import 'package:prestamos_app/screens/home_page.dart';
import 'firebase_options.dart';
import 'screens/client_pages/client_details_page.dart';
import 'screens/client_pages/clients_page.dart';
import 'screens/loan_pages/loan_details_page.dart';
import 'screens/search_page.dart';
import 'screens/setttings_page.dart';

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
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/clients': (context) => const ClientsPage(),
        '/search': (context) => const SearchPage(),
        '/settings': (context) => const SettingsPage(),
        '/loan_details': (context) => LoanDetailsPage(),
        '/client_details': (context) => ClientDetailsPage(),
      },
      home: const AuthPage(),
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
        fontFamily: 'Poppins'
      ),
    );
  }
}
