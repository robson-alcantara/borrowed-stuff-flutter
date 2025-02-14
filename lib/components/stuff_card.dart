import 'dart:io';

import 'package:flutter/material.dart';

import 'package:borrowed_stuff/models/stuff.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StuffCard extends StatelessWidget {
  final Stuff stuff;
  final Function onEdit;
  final Function onDelete;

  const StuffCard({
    required Key? key,
    required this.stuff,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSlidableStuffCard();
  }

  _buildStuffCard(Stuff stuff) {
    return Card(
      child: ListTile(
        title: Text(stuff.description!),
        subtitle: Text(stuff.contactName!),
        leading: CircleAvatar(
          child: stuff.photoExist
              ? null
              : Text('${stuff.description?.toUpperCase()[0]}'),
          backgroundImage:
              stuff.photoExist ? FileImage(File(stuff.photoPath!)) : null,
        ),
        trailing: Text(stuff.loadDateString),
      ),
    );
  }

  _buildSlidableStuffCard() {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildStuffCard(stuff),
      actions: const <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.blue,
          icon: Icons.edit,
          //onTap: onEdit, ///TODO: ativar código
        ),
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          //onTap: onDelete, ///TODO: ativar código
        ),
      ],
    );
  }
}
