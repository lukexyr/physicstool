import 'package:flutter/material.dart';

class MyGridNaming extends StatelessWidget {
  final ValueChanged<String>? onTextChanged;
  final TextEditingController controller;

  MyGridNaming({Key? key, this.onTextChanged, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 480,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0),
      ),
      child: SizedBox(
        child: TextField(
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          controller: controller,
          onChanged: (text) {
            onTextChanged?.call(text);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Inhalt eingeben',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
