import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

// Paginas
import 'package:uppah_0_0_0/pages/home_page.dart';

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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 50, // tamaño del appbar
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: (IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: Image.asset('assets/BackArrow.png'),
          iconSize: 60.0,
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Se activa el nfc
                          child



                        },
                        icon: Image.asset("assets/unlocked (1).png"),
                        iconSize: 100.0,
                        splashRadius: 70,
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
