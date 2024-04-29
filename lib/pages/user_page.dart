import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/Firebase/firestore_service.dart';

class UserPage extends StatelessWidget {
  final Future<String> text =
      FirestoreService().createTextWithGaps('WXoxYKcgK9xHd5B0mO5V');
  final Future<List<Map<String, dynamic>>> missingWords =
      FirestoreService().getMissingWords('WXoxYKcgK9xHd5B0mO5V');

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
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>>
                    missingWordsSnapshot) {
              if (missingWordsSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Container();
              } else if (missingWordsSnapshot.hasError) {
                return Text('Error: ${missingWordsSnapshot.error}');
              } else {
                return FullHeightTextPage(
                    text: snapshot.data!,
                    missingWords: missingWordsSnapshot.data!);
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

  const FullHeightTextPage(
      {super.key, required this.text, required this.missingWords});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth / 6;
    double verticalPadding = 20.0;
    double textSize = 24.0;

    List<String> words = text.split(' ');

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 15.0,
                  children: words.asMap().entries.map((entry) {
                    int index = entry.key;
                    String word = entry.value;
                    if (missingWords.any(
                        (missingWord) => missingWord['Position'] == index)) {
                      var missingWord = missingWords.firstWhere(
                          (missingWord) => missingWord['Position'] == index);
                      return _DragTargetBox(
                          missingWord: missingWord,
                          textSize: textSize,
                          index: index);
                    }
                    return Text(word);
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 100,
              child: ListView(
                children: List.generate(missingWords.length, (index) {
                  var missingWord = missingWords[index];
                  return Draggable<String>(
                    data: missingWord['Wort'],
                    feedback: Material(
                      child: Text(missingWord['Wort']),
                    ),
                    childWhenDragging: const Text(''),
                    child: Text(missingWord['Wort']),
                  );
                }),
              ),
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

  const _DragTargetBox(
      {required this.missingWord, required this.textSize, required this.index});

  @override
  _DragTargetBoxState createState() => _DragTargetBoxState();
}

class _DragTargetBoxState extends State<_DragTargetBox> {
  String? currentWord;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double paddingWidth = 10.0;
        double boxWidth =
            (currentWord != null ? currentWord!.length * 10.0 : 50.0) +
                paddingWidth;
        double boxHeight = widget.textSize + 10;
        double maxWidth = constraints.maxWidth;
        double minWidth = 70.0;

        if (currentWord != null && boxWidth < minWidth) {
          boxWidth = minWidth;
        } else if (currentWord != null && boxWidth > maxWidth) {
          boxWidth = maxWidth;
        }

        if (currentWord == null) {
          boxWidth = minWidth;
        }

        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return SizedBox(
              width: boxWidth,
              height: boxHeight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: currentWord == null
                        ? Colors.black
                        : isCorrect
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: currentWord == null
                      ? null
                      : Draggable<String>(
                          data: currentWord,
                          feedback: Material(
                            child: Text(currentWord!),
                          ),
                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              currentWord = null;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              currentWord = null;
                            });
                          },
                          child: Text(
                            currentWord!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            );
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            setState(() {
              currentWord = data;
              isCorrect = widget.missingWord['Wort'] == data;
            });
          },
        );
      },
    );
  }
}
