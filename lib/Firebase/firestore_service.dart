import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> retrieveText(String docId) async {
    DocumentSnapshot docSnapshot =
    await _firestore.doc('Arbeitsblätter/$docId').get();
    return docSnapshot.get('Text') as String;
  }

  Future<void> addMissingWord(String docId, String word, int position) async {
    await _firestore.doc('Arbeitsblätter/$docId/Lücken/Lücke$position').set({
      'word': word,
      'Position': position, // Change to 'Position'
    });
  }

  Future<List<Map<String, dynamic>>> getMissingWords(String docId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('Arbeitsblätter/$docId/Lücken').get();
    List<Map<String, dynamic>> missingWords = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    print("Missing words from Firestore: $missingWords");
    return missingWords;
  }


  Future<String> createTextWithGaps(String docId) async {
    String text = await retrieveText(docId);
    List<Map<String, dynamic>> missingWords = await getMissingWords(docId);
    List<String> words = text.split(' ');

    for (var missingWord in missingWords) {
      if (missingWord['Position'] != null) {
        int position = missingWord['Position'];
        print("Position from Firestore: $position");
        if (position < words.length) {
          words[position] = '___';
          print("Index in text: $position");
        }
      }
    }

    return words.join(' ');
  }

}