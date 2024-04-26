import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/components/my_button.dart';
import 'package:physicstool/pages/drop_zone.dart';
import 'package:physicstool/pages/grid_page.dart';
import 'package:physicstool/pages/my_grid_naming.dart';
import 'package:physicstool/pages/text_page.dart';
import 'package:physicstool/pages/my_grid_builder.dart';

class TextScreen extends StatefulWidget {
  TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1),
              ),
              child: const Column(
                children: [
                  Expanded(
                    child: TextPage(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20), // Abstand zwischen den Containern
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropZone(),
                SizedBox(height: 20),
                Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: Center(
                    child: Icon(Icons.settings),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
