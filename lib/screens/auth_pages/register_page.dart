import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/screens/auth_pages/login_page.dart';
import 'package:prestamos_app/widgets/auth/signInWith.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showmessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(errorMessage));
        });
  }

  void _signUserup(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showmessage("Password does not match");
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //wrong Email
      showmessage(e.code);
    }
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
                                'Regístrate para continuar',
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
                              controller: _emailController,
                              placeHolder: "ej: fulano@gmail.com",
                              obscureText: false),
                          const SizedBox(height: 23),
                          MyTextField(
                              label: "Contraseña",
                              controller: _passwordController,
                              placeHolder: "•••••••",
                              obscureText: true),
                          const SizedBox(height: 23),
                          MyTextField(
                              label: "Confirmar Contraseña",
                              controller: _confirmPasswordController,
                              placeHolder: "•••••••",
                              obscureText: true),
                          const SizedBox(height: 23),
                          MyButton(
                            onTap: () => _signUserup(context),
                            label: "REGISTRATE",
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
                      'Ya estas registrado?  ',
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
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Inicia Sesión',
                          style: TextStyle(
                            color: Color(0xFF8C19FF),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//             child: ListView(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 166.22,
//                   height: 166.22,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/img/libro-de-arte.png'),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 52),
//                 const Text(
//                   'Registro',
//                   style: TextStyle(
//                     color: Color(0xFF464E47),
//                     fontSize: 24,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w500,
//                     height: 0,
//                   ),
//                 ),
//                 const SizedBox(height: 29),
//                 TextInput(
//                   controller: _emailController,
//                   hintText: 'Correo Electronico',
//                 ),
//                 const SizedBox(height: 17),
//                 TextInput(
//                   controller: _passwordController,
//                   hintText: 'Contraseña',
//                 ),
//                 const SizedBox(height: 17),
//                 // TextInput(
//                 //   controller: _confirmPasswordController,
//                 //   hintText: 'Confirmar Contraseña',
//                 // ),
//                 MyTextField(label: "Confirmar Contraseña",controller: _confirmPasswordController, placeHolder: "•••••••", obscureText: true),
//                 const SizedBox(height: 32),
//                 MyButton(
//                   onTap: () => _signUserup(context),
//                   label: "Registrarse",
//                 ),
//                 const SizedBox(height: 32),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text(
//                           'Or continue with',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 const SignInWith(),
//                 const SizedBox(height: 50),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Ya tienes una cuenta?',
//                       style: TextStyle(
//                         color: Color(0xFF464C52),
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w500,
//                         height: 0,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'Inicia Sesión',
//                         style: TextStyle(
//                           color: Color(0xFF403EAF),
//                           fontSize: 16,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

