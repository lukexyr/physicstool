import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.name, required this.onPressed});

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(name, style: TextStyle(color: Colors.black)),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: Size(200, 60)  // Set the minimum size here
      ),
    );
  }
}