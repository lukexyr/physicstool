import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/Firebase/firestore_service.dart';
import 'package:physicstool/screens/grid_screen.dart';
import 'package:physicstool/screens/text_screen.dart';

class UserPage extends StatelessWidget {
  final Future<String> text = FirestoreService().createTextWithGaps('WXoxYKcgK9xHd5B0mO5V');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: text,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return FullHeightTextPage(text: snapshot.data!);
        }
      },
    );
  }
}

class FullHeightTextPage extends StatelessWidget {
  final String text;

  FullHeightTextPage({required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth / 3;
    double verticalPadding = 20.0;
    double textSize = 24.0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: SingleChildScrollView(
          child: Text(
            text,
            style: TextStyle(fontSize: textSize),
          ),
        ),
      ),
    );
  }
}