import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestamos_app/widgets/settings/settings_option.dart';
import '../screens/login_page.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(

//     );
//     // Padding(
//     //   padding: const EdgeInsets.all(10.0),
//     //   child: Column(
//     //           children: [
//     //             Container(
//     //               decoration: BoxDecoration(
//     //                 color: Colors.white,
//     //                 borderRadius: BorderRadius.circular(10),
//     //                 boxShadow: const [
//     //                   BoxShadow(
//     //                     color: Color.fromARGB(255, 222, 220, 220),
//     //                     spreadRadius: 4,
//     //                     blurRadius: 7,
//     //                     offset: Offset(0, 2),
//     //                   )
//     //                 ]
//     //               ),
//     //               child: ListTile(
//     //                 leading: const Icon(Icons.logout_outlined),
//     //                 title: const Text('Cerrar sesión'),
//     //                 subtitle: const Text(''),
//     //                 onTap: (){
//     //                   logOut(context);
//     //                 },
//     //                 onLongPress: (){},
//     //               ),
//     //             ),
//     //             const SizedBox(height: 15),
//     //           ]
//     //   ),
//     // );
//   }
// }

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error al cerrar sesión: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(13, 61, 171, 1)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 112,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 21),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://s3-alpha-sig.figma.com/img/8252/dff0/74bbf2ed399496a6b6867770170d23e9?Expires=1699228800&Signature=YjMTCwC~IWAsyK~kdSSsJD2FW7VVvCS6uT0DvF2uWFBYPj27B3X5maBljoWBsRThK1JC~elGeAOldWtGurVz9eSytXTm5Ip880rAjEWVKVQFMuSH3JXqiMTGCXuZaOzqAsW8qltm85CesfuiT0uuKlbSA4RrSmcWBYEQIc73lLQ~voCJHRKWXjhpsaWU7LhuGdCmYBJJy7BzVkhqBJEYiKPs-seAdsl6zCsKLx8NhAM-XfqjblHeyXOrLrIjAV1ezqnGpb1~LdT1OEDY~tTv~r3K3G5A5-7WmlmQksB~7kiXzbaylSJ31CJFhgqHmrcyLoV8YorSp4AJqYhKD6g1gQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Cristian Tejeda',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'cristiantejeda12@gmail.com',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 44,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: Colors.white
                                      .withOpacity(0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.logout_outlined,
                                  size: 20.0,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'General',
                                            style: TextStyle(
                                              color: Color(0xFF332323),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.07,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SettingOption(
                                            label: "Mi perfil",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.account_circle_outlined,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SettingOption(
                                            label: "Configuración",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.settings_outlined,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SettingOption(
                                            label: "Notificaciones",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.notifications_outlined,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Soporte y ayuda',
                                            style: TextStyle(
                                              color: Color(0xFF332323),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.07,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SettingOption(
                                            label: "Centro de ayuda",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.headphones_rounded,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
                                            ),
                                          ),
                                          
                                          SettingOption(
                                            label: "Acerca de",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.info_outline,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
                                            ),
                                          ),

                                          SettingOption(
                                            label: "Feedback",
                                            onTap: () {
                                              logOut(context);
                                            },
                                            icono: const Icon(
                                              Icons.account_circle_outlined,
                                              color: Color.fromRGBO(
                                                  13, 71, 161, 1),
                                              size: 20.0,
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
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 58,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2023 App_Prestamos v1.0.212',
                                      style: TextStyle(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
