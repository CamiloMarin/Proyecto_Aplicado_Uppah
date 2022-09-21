import 'package:flutter/material.dart';

showAlertDialogWrongEmail(BuildContext context) {
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
}

showAlertDialogWrongPassword(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Listo!"),
    onPressed: () => Navigator.pop(context, 'Cancel'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Contraseña incorrecta"),
    content: Text("Confirma que tu contraseña sea igual en ambos campos"),
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
}

showAlertDialogWrongPassword2(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Listo!"),
    onPressed: () => Navigator.pop(context, 'Cancel'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Contraseña incorrecta"),
    content: Text("Este campo solo acepta 6 dígitos y deben ser numéricos"),
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
}

showAlertDialogEmailInUse(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Listo!"),
    onPressed: () => Navigator.pop(context, 'Cancel'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Correo en uso"),
    content: Text(
        "El correo que usaste ya está registrado o está pendiente de su verificación"),
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
}
