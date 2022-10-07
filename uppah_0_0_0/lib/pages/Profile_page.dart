import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uppah_0_0_0/pages/home_page.dart';

// nfc
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:ndef/ndef.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
            image: AssetImage('assets/Carnet_reference_uppah.jpg'),
            height: 500,
            width: 500),
        SizedBox(height: 100),
        // Btn de nfc
        MaterialButton(
          onPressed: () {
            // nfc key
          },
          color: Colors.amber,
          child: Text('Regresar'),
        ),
      ])),
    );
  }
}
