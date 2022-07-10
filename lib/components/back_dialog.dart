import 'package:flutter/material.dart';

class BackDialog extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;

  const BackDialog({required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Sair do empréstimo?'),
      content: Text('Você tem certeza que deseja sair do empréstimo?'),

      /// TODO: atualizar código abaixo
      // actions: <Widget>[
      //   FlatButton(
      //     child: Text('Não'),
      //     onPressed: onConfirm,
      //   ),
      //   FlatButton(
      //     child: Text('Sim'),
      //     onPressed: onCancel,
      //   ),
      //],
    );
  }
}
