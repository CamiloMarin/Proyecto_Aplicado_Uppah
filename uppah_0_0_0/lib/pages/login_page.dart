// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        Alert(
          //se puede usar el atributo de style
          type: AlertType.error,
          context: context,
          title: "Contraseña incorrecta",
          desc: "La contraseña que has ingresado no coincide",
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
      } else if (err.code == 'invalid-email') {
        Alert(
          //se puede usar el atributo de style
          type: AlertType.error,
          context: context,
          title: "Dominio inválido",
          desc: "Tu correo debe terminar en @soyudemedellin.edu.co",
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
      } else if (err.code == 'user-not-found') {
        Alert(
          //se puede usar el atributo de style
          type: AlertType.error,
          context: context,
          title: "Cuenta inexistente",
          desc: "El correo con el que intentas ingresar no está registrado",
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
        print(err.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  height: 200,
                  width: 200),
              //Hello again!
              Text(
                '¡Bienvenido a Uppah!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              SizedBox(height: 40),
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
                    hintText: 'Tu correo institucional',
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
                    hintText: 'Tu contraseña',
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
                    child: Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18)),

                    onPressed: signIn, //signUp,
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
                    'No estás registrado?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      ' Registrate ahora',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 106, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
