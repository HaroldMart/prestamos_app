import 'package:flutter/material.dart';

class SettingOption extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Icon icono;

  const SettingOption(
      {super.key,
      required this.onTap,
      this.label = 'Label',
      required this.icono});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: (){},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.05000000074505806),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 42,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container( // Contenedor de el circulo con el icono
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.none,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFBBDEFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: icono,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
                width: 28,
                height: 28,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  size: 16.0,
                )),
          ],
        ),
      ),
    );
  }
}
