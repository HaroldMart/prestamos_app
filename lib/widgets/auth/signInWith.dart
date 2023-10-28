import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/widgets/square_tile.dart';
import '../../screens/tabs_screen.dart';
import '../../auth/signin_google.dart';

class SignInWith extends StatefulWidget {
  const SignInWith({super.key});

  @override
  State<SignInWith> createState() => _SignInWithState();
}

class _SignInWithState extends State<SignInWith> {
  Future<void> handleSignInWithGoogle() async {
    try {
      final User? user = await signInWithGoogle();

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabsScreen(),
          ),
        );
      }
    } catch (error) {
      // Maneja errores aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //Texto de "o continua con"
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE9EBED),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'o continua con',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE9EBED),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Container(
            width: double.infinity,
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.56,
                        height: 28.56,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://s3-alpha-sig.figma.com/img/3f80/d64c/2ce172ebe6473811e211cf10b2b6dd72?Expires=1699228800&Signature=oHQc0QD0kdULfkd~DG9bEJuw4xY-4F7KHVf0GmjDJUf-oy6X3L-vVL2oGHgNCv~H-D4vfb~XumdITu1OIjPSuJLIFU9V52LnxapKN0viaBaHSwNe8xOasXAAYyzRPN8No9hf3zcIJklPgco2IRRxD-XvhqRGDHQX9WG9uNOLDXDGF9JOT~xOnbDUAkY7c4ebfxbvuFAKbx6hn7uYSoSw9Y~QqBgE-mawLCVzaZIfmKHD1oadtk6JfMXggYkrIGrv6hAHShOpYeOJD4lBMoUEl-ok7SQnRtqIqSEXOsl2pY9-UbDDZXWprVKeCmj4teQbilH8IzToPGYsYeGO9eHBjw__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.56,
                        height: 28.56,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://s3-alpha-sig.figma.com/img/0ee0/5e90/1f41640f8f807ea497b89a127309829c?Expires=1699228800&Signature=O6MdpbqnUDQ0-COhlK-yFz5j1h6Lk1aqM7RofKU~9TkNAqmraUGHqLZMCAPLfBG6tSf0IcaLyd~X4AvIKeld0mktz4DNEw1OoGlRJFxA30hGL2mtPQUaCjgye-1LfL5t5fVMBlyfAJMI7V2P75PXzs25Snz6JHfqt7w1ZNNfztF5J8mNE3PoGRne1ts8TWk7wagg-UC0eyemAXOoHsXhdvhJvZzhcdlUd27CaJRepNLy8~1PWGoCekm8TkOk48owhDy4l0MGGM-y-5GM1-JK6gn0SRWy6n6Tv4JMVGPiM7QaRpV9X4XsN8xronIysOljG8vpFm~oBZ5VwbjDBqeiGQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.56,
                        height: 28.56,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://s3-alpha-sig.figma.com/img/936c/3ffc/387aed2e0e6b9fecb4ea69befad9fc04?Expires=1699228800&Signature=nEotNJuYSmebIbgo5JNEJR21wdak063v13FMMZHTov3nqJXKzl50KQ5AUh7hOEen7Zkz3r5Ug3onw4qCy05hvDWwuTeR2vwwpO0ZM1P8ORwYzWHFRx7d7ozr2KWwM96sY4B7APNlyrQNgMCZbRhE8yRl0ws8pDGW-JoYlw24aXasADOVMT4BupSP6ludxQdpTQKmLPW4smuNsKNwuKZ4gwud1ib3ip~onAw6mu8mmSqS5wYd08mSiyLF~M-Wr3gLf8iEGUrLlRYuGitdwDi6KlCLqYjqTpzhCmnwG-IdhrdAQgafK5S7abZUV7SVUILMw-RiZptil0K2xps-BjBE3A__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     InkWell(
    //         onTap: () {
    //           handleSignInWithGoogle();
    //         },
    //         child: const SquareTile(
    //           imagePath: 'assets/google.png',
    //         )),
    //     const SizedBox(width: 15),
    //     const SquareTile(imagePath: 'assets/apple.png')
    //   ],
    // )
  }
}
