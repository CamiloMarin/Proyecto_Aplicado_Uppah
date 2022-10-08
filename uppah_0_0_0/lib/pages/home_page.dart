import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uppah_0_0_0/pages/gym_page.dart';
import 'package:uppah_0_0_0/pages/digital_card_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  String myFirstName = '';
  String myEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Image.asset("assets/uppah_simple_orange.png"),
                          iconSize: 60.0,
                          //padding: EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        // Spacer(),
                        IconButton(
                          onPressed: null,
                          icon: Image.asset("assets/BotonPerfil.png"),
                          iconSize: 50.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '¡',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    'Bienvenid@ ',
                    style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text('');
                      return Text(
                        "$myFirstName!",
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '¿Qué quieres hacer hoy?',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 50.0, top: 25.0, right: 50.0),
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
                                          const DigitalCard()),
                                );
                              },
                              icon: Image.asset("assets/BotonCarnet.png"),
                              iconSize: 80.0,
                            ),
                            Text('Carnet',
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
                              icon: Image.asset("assets/BotonHorario.png"),
                              iconSize: 80.0,
                            ),
                            Text('Horario',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GymPage()),
                                );
                              },
                              icon: Image.asset("assets/BotonReservas.png"),
                              iconSize: 80.0,
                            ),
                            Text('Reservas',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Image.asset("assets/BotonCalculadora.png"),
                              iconSize: 80.0,
                            ),
                            Text('Calculadora',
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
                              icon: Image.asset("assets/BotonAgenda.png"),
                              iconSize: 80.0,
                            ),
                            Text('Agenda',
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
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nuestros ',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'grupos de investigación',
                    style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.amber,
                child: Text('salir'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((docSnapshot) {
      myFirstName = docSnapshot.data()!['Nombres'];
      myEmail = docSnapshot.data()!['Correo'];
    });
  }
}
