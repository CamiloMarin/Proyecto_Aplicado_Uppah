// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/alerts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _documentController = TextEditingController();
  final careers = [
    'Comunicación y Entretenimiento Digital',
    'Comunicación y Lenguajes Audiovisuales',
    'Comunicación Gráfica Publicitaria',
    'Comunicación y Relaciones Corporativas',
    'Derecho'
  ];
  String? value;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool checkUdeM() {
    final String emailTrim = _emailController.text.trim();
    final containsUdeM = emailTrim.contains('@soyudemedellin.edu.co');
    if (containsUdeM) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    //Authenticate user and checks
    if (checkUdeM()) {
      if (passwordConfirmed()) {
        if (_passwordController.text.length == 6 &&
            isNumeric(_passwordController.text)) {
          try {
            //create user
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());
            //add user details
            addUserDetails(
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _documentController.text.trim(),
              value.toString(),
              _emailController.text.trim(),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              Alert(
                //se puede usar el atributo de style
                type: AlertType.error,
                context: context,
                title: "Contraseña débil",
                desc: "La contraseña que has ingresado es muy fácil",
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
            } else if (e.code == 'email-already-in-use') {
              Alert(
                //se puede usar el atributo de style
                type: AlertType.error,
                context: context,
                title: "Correo en uso",
                desc: "Este correo ya está en uso o pendiente de verificación",
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
        } else {
          showAlertDialogWrongPassword2(context);
        }
      } else {
        showAlertDialogWrongPassword(context);
      }
    } else {
      showAlertDialogWrongEmail(context);
    }
  }

  Future addUserDetails(String firstName, String lastName, String document,
      String career, String email) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set({
      'Nombres': firstName,
      'Apellidos': lastName,
      'Cedula': document,
      'Carrera': career,
      'Correo': email,
      'UID': firebaseUser.uid,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool isNumeric(String str) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image(
                  image: AssetImage('assets/uppah_simple_orange.png'),
                  height: 80,
                  width: 80),
              //Hello again!
              Text(
                'Bienvenid@,',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'regístrate y mejora tu experiencia universitaria',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              //Name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'Nombres',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Lastname textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'Apellidos',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //document textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  obscureText: false,
                  controller: _documentController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'Cédula',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //Career textfield
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Carrera"),
                    dropdownColor: Colors.white,
                    value: value,
                    isExpanded: true,
                    items: careers.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => this.value = value),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'Correo institucional',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'contraseña',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),
              SizedBox(height: 20),

              //password confirm textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  obscureText: true,
                  controller: _confirmpasswordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: 'confirma tu contraseña',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),
              SizedBox(height: 20),

              //sign_in
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Registrarse'),
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18)),

                    onPressed: signUp, //signUp,
                  ),
                ),
              ),
              SizedBox(height: 25),
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Ya tienes una cuenta?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      ' Ingresa ahora',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 106, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ]),
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ));
}

/* showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Listo!"),
    onPressed: () => Navigator.pop(context, 'Cancel'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Correo inválido"),
    content: Text("Tu correo debe terminar en @soyudemedellin.edu.co"),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
} */
