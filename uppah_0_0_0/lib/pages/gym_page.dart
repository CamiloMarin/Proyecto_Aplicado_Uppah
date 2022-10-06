import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uppah_0_0_0/pages/home_page.dart';

class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  String myFirstName = '';
  String myLastName = '';
  String myDocument = '';
  String? value;
  String? value_dias;
  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final turnos = [
    'Turno 1: 6-8',
    'Turno 2: 8-10',
    'Turno 3: 10-12',
    'Turno 4: 12-2',
    'Turno 5: 2-4'
  ];
  final dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Text('Cargando...');
            return Text("Hola $myFirstName");
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[200],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Elige el día',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value_dias,
                      isExpanded: true,
                      items: dias.map(buildMenuItem).toList(),
                      onChanged: (value_dias) =>
                          setState(() => this.value_dias = value_dias),
                    ),
                  ),
                ),
                Text(
                  'Elige tu turno',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      items: turnos.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => sendEmail(
                    day: value_dias.toString(),
                    turno: value.toString(),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.orange[900],
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Reservar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendEmail({
    required String day,
    required String turno,
  }) async {
    if (day != 'null' && turno != 'null') {
      final serviceId = 'service_qy3akdl';
      final templateId = 'template_g83pglh';
      final userId = 'nX8t3p1R01BvHvjYr';
      final userEmail = FirebaseAuth.instance.currentUser!.email;
      final userDocument = myDocument;
      String nameFinal = myFirstName + ' ' + myLastName;
      final name = nameFinal;
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

      var response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'horario': turno,
              'reply_to': userEmail,
              'from_name': name,
              'document': userDocument,
              'day': day,
            }
          }));
      Alert(
        //se puede usar el atributo de style
        type: AlertType.success,
        context: context,
        title: "Correo enviado",
        desc:
            "Tu reserva se envió con éxito, recuerda estar pendiente de tu correo para ver la respuesta",
        buttons: [
          DialogButton(
            child: Text(
              "Listo!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      Alert(
        //se puede usar el atributo de style
        type: AlertType.error,
        context: context,
        title: "Campos insuficientes",
        desc: "Debes rellenar todos los campos para enviar el correo!",
        buttons: [
          DialogButton(
            child: Text(
              "Listo!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((docSnapshot) {
      myFirstName = docSnapshot.data()!['Nombres'];
      myLastName = docSnapshot.data()!['Apellidos'];
      myDocument = docSnapshot.data()!['Cedula'];
    });
  }
}
