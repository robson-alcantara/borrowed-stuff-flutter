import 'package:another_flushbar/flushbar.dart';
import 'package:borrowed_stuff/components/centered_circular_progress.dart';
import 'package:borrowed_stuff/components/centered_message.dart';
import 'package:borrowed_stuff/components/stuff_card.dart';
import 'package:borrowed_stuff/controllers/home_controller.dart';
import 'package:borrowed_stuff/models/stuff.dart';
import 'package:borrowed_stuff/pages/sutff_detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller.readAll().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetos Emprestados'),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: _buildStuffList(),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      label: const Text('Emprestar'),
      icon: const Icon(Icons.add),
      onPressed: _addStuff,
    );
  }

  _buildStuffList() {
    if (_loading) {
      return const CenteredCircularProgress();
    }

    if (_controller.stuffList.isEmpty) {
      return const CenteredMessage('Vazio', icon: Icons.warning);
    }

    return ListView.builder(
      itemCount: _controller.stuffList.length,
      itemBuilder: (context, index) {
        final stuff = _controller.stuffList[index];
        return StuffCard(
          stuff: stuff,
          onDelete: () {
            _deleteStuff(stuff);
          },
          onEdit: () {
            _editStuff(index, stuff);
          },
          key: null,
        );
      },
    );
  }

  _addStuff() async {
    print('New stuff');
    final stuff = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StuffDetailPage()),
    );

    if (stuff != null) {
      setState(() {
        _controller.create(stuff);
      });

      Flushbar(
        title: "Novo empréstimo",
        backgroundColor: Colors.black,
        message: "${stuff.description} emprestado para ${stuff.contactName}.",
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  _editStuff(index, stuff) async {
    print('Edit stuff');
    final editedStuff = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StuffDetailPage(editedStuff: stuff)),
    );

    if (editedStuff != null) {
      setState(() {
        _controller.update(index, editedStuff);
      });

      Flushbar(
        title: "Empréstimo atualizado",
        backgroundColor: Colors.black,
        message:
            "${editedStuff.description} emprestado para ${editedStuff.contactName}.",
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  _deleteStuff(Stuff stuff) {
    print('Delete stuff');
    setState(() {
      _controller.delete(stuff);
    });

    Flushbar(
      title: "Exclusão",
      backgroundColor: Colors.red,
      message: "${stuff.description} excluido com sucesso.",
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
