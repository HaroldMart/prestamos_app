// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/screens/auth_pages/register_page.dart';
import 'package:prestamos_app/widgets/auth/signInWith.dart';
import 'package:prestamos_app/widgets/my_textfield.dart';
import '../tabs_screen.dart';
import '../../widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool? check1 = false;

  void showmessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(errorMessage));
        });
  }

  // sign user in method
  Future<void> signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (kDebugMode) {
        print(userCredentials);
      }
      if (userCredentials != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabsScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //wrong Email
      showmessage(e.code);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 43,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                'Accede para continuar',
                                style: TextStyle(
                                    color: Color(0xFF1E293B),
                                    fontSize: 40,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.none,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyTextField(
                              label: "Correo Electronico",
                              controller: emailController,
                              placeHolder: "ej: fulano@gmail.com",
                              obscureText: false),
                          const SizedBox(height: 23),
                          MyTextField(
                              label: "Contraseña",
                              controller: passwordController,
                              placeHolder: "•••••••",
                              obscureText: true),
                          const SizedBox(height: 23),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: check1, //valor del checkbox
                                        checkColor: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        activeColor: const Color.fromRGBO(
                                            21, 101, 192, 1),
                                        onChanged: (bool? value) {
                                          //valor devuelto cuando el usuario hace clic en el checkbox
                                          setState(() {
                                            check1 =
                                                value; //actualizar el valor del checkbox
                                          });
                                        }),
                                    const Text(
                                      'Remember me',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Reset password',
                                  style: TextStyle(
                                    color: Color(0xFF8E74F5),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 23),
                          MyButton(
                            onTap: signUserIn,
                            label: "INICIAR SESIÓN",
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // AQUI VA EL SIGN IN WITH
                    const SignInWith(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Aun no tienes una cuenta?  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Registrate',
                        style: TextStyle(
                          color: Color(0xFF8C19FF),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
