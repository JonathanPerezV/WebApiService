// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

showAlertIdIsEmpty(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title.toUpperCase()),
          content: Text(
              'Para poder ${title.toLowerCase()} la revista, primero haga una busqueda'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'))
          ],
        );
      });
}

showRevistaNoEncontrada(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text('No encontrado'),
          content: const Text(
              'La revista con el id ingresado no ha sido encontrada'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'))
          ],
        );
      });
}
