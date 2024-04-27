import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/Firebase/firestore_service.dart';
import 'package:physicstool/screens/grid_screen.dart';
import 'package:physicstool/screens/text_screen.dart';

class UserPage extends StatelessWidget {
  final Future<String> text = FirestoreService().retrieveText();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: text,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
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
  final String text; // This will be the text retrieved from Firebase Firestore

  FullHeightTextPage({required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth / 3; // Calculate the horizontal padding
    double verticalPadding = 20.0; // Set the vertical padding
    double textSize = 24.0; // Set the text size

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding), // Add padding here
            child: Text(
              text,
              style: TextStyle(fontSize: textSize), // Increase the text size here
            ),
          ),
        ),
      ),
    );
  }
}