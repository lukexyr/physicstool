import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  List<TextEditingController> _controllers = [TextEditingController()];
  List<bool> _showAddButton = [true];


  void _addInputField() {
    setState(() {
      _controllers.add(TextEditingController());
      _showAddButton.add(true);
      _showAddButton[_showAddButton.length - 2] = false;
    });
  }

  void _removeInputField(int index) {
    setState(() {
      _controllers.removeAt(index);
      _showAddButton.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: _controllers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: TextFormField(
                controller: _controllers[index],
                decoration: const InputDecoration(
                  hintText: 'Teilabschnitt des Gesamttextes',
                  border: OutlineInputBorder(),
                ),
              ),
              trailing: _showAddButton[index]
                  ? IconButton(
                icon: Icon(CupertinoIcons.add_circled),
                onPressed: _addInputField,
              )
                  : IconButton(
                icon: Icon(CupertinoIcons.minus_circled),
                onPressed: () => _removeInputField(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
