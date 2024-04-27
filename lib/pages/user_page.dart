import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/Firebase/firestore_service.dart';
import 'package:physicstool/screens/grid_screen.dart';
import 'package:physicstool/screens/text_screen.dart';

class UserPage extends StatelessWidget {
  final Future<String> text = FirestoreService().createTextWithGaps('WXoxYKcgK9xHd5B0mO5V');
  final Future<List<Map<String, dynamic>>> missingWords = FirestoreService().getMissingWords('WXoxYKcgK9xHd5B0mO5V');

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
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: missingWords,
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> missingWordsSnapshot) {
              if (missingWordsSnapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (missingWordsSnapshot.hasError) {
                return Text('Error: ${missingWordsSnapshot.error}');
              } else {
                return FullHeightTextPage(text: snapshot.data!, missingWords: missingWordsSnapshot.data!);
              }
            },
          );
        }
      },
    );
  }
}

class FullHeightTextPage extends StatelessWidget {
  final String text;
  final List<Map<String, dynamic>> missingWords;

  FullHeightTextPage({required this.text, required this.missingWords});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth / 3;
    double verticalPadding = 20.0;
    double textSize = 24.0;

    List<String> words = text.split(' ');

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: words.asMap().entries.map((entry) {
                    int index = entry.key;
                    String word = entry.value;
                    if (missingWords.any((missingWord) => missingWord['Position'] == index)) {
                      var missingWord = missingWords.firstWhere((missingWord) => missingWord['Position'] == index);
                      return _DragTargetBox(missingWord: missingWord, textSize: textSize, index: index); // Pass index
                    }
                    return Text(word);
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            child: ListView(
              children: List.generate(missingWords.length, (index) {
                var missingWord = missingWords[index];
                return Draggable<String>(
                  data: missingWord['Wort'],
                  child: Text(missingWord['Wort']),
                  feedback: Material(
                    child: Text(missingWord['Wort']),
                  ),
                  childWhenDragging: Text(''),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}




class _DragTargetBox extends StatefulWidget {
  final Map<String, dynamic> missingWord;
  final double textSize;
  final int index;

  _DragTargetBox({required this.missingWord, required this.textSize, required this.index});

  @override
  _DragTargetBoxState createState() => _DragTargetBoxState();
}

class _DragTargetBoxState extends State<_DragTargetBox> {
  String? currentWord;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return SizedBox(
          minWidth: 100.0, // Adjust this value as needed
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: isCorrect ? Colors.green : Colors.black),
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text(currentWord ?? '')),
          ),
        );
      },
      onWillAccept: (data) {
        return widget.missingWord['Wort'] == data;
      },
      onAccept: (data) {
        setState(() {
          currentWord = data;
          isCorrect = widget.missingWord['Wort'] == data;
        });
      },
    );
  }
}
