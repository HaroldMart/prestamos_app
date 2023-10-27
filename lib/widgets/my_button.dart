import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const MyButton({super.key, required this.onTap, this.label = 'Label'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 350,
          height: 52,
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF1565C0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //   child: Container(
        //     width: 350,
        //     height: 58,
        //     decoration: ShapeDecoration(
        //       color: const Color(0xFF568259),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(14),
        //       ),
        //     ),
        //     child: const Row(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           'Iniciar Sesión',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 18,
        //             fontFamily: 'Inter',
        //             fontWeight: FontWeight.w500,
        //             height: 0,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
