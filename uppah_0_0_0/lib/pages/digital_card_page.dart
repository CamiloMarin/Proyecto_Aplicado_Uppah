import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

// Paginas
import 'package:uppah_0_0_0/pages/home_page.dart';

// nfc - ndef y su modo de operacion ()
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart' as ios;

class DigitalCard extends StatefulWidget {
  const DigitalCard({super.key});

  @override
  State<DigitalCard> createState() => _DigitalCardState();
}

class _DigitalCardState extends State<DigitalCard> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 50.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Image.asset('assets/BackArrow.png'),
                    iconSize: 50.0,
                  ),
                  IconButton(
                    onPressed: () {
                      //Navigator.of(context).pop();
                    },
                    icon: Image.asset('assets/EditUserBlanco.png'),
                    iconSize: 50.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 00.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tú ',
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                        ),
                      ),
                      Text(
                        'Carnet ',
                        style: GoogleFonts.quicksand(
                          color: Color.fromARGB(255, 255, 106, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(bottom: 00.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/CarnetDigital.PNG',
                          width: 288, height: 400, fit: BoxFit.cover)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 222, 222),
                            blurRadius: 5.0,
                          )
                        ]),
                        child: IconButton(
                          onPressed: () {
                            // Se activa el nfc
                          },
                          icon: Image.asset("assets/unlocked (1).png"),
                          iconSize: 150.0,
                          splashRadius: 70,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
