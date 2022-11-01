import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uppah_0_0_0/pages/gym_page.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({super.key});

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  @override
  void initState() {
    super.initState();

    //profileImageFuture = getDownloadUrl(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_reservas.jpeg'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Haz una reserva',
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 80,
                    endIndent: 80,
                    color: Color.fromARGB(255, 255, 106, 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 60.0, top: 25.0, right: 60.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GymPage()),
                                    );
                                  },
                                  icon: Image.asset("assets/BotonGym.png"),
                                  iconSize: 70.0,
                                ),
                                Text('Gimnasio',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  icon: Image.asset("assets/BotonPiscina.png"),
                                  iconSize: 70.0,
                                ),
                                Text('Piscina',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  icon: Image.asset("assets/BotonCDC.png"),
                                  iconSize: 70.0,
                                ),
                                Text('CDC',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.white,
          child: Image.asset("assets/BackArrow.png"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
