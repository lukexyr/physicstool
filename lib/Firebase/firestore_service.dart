import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> retrieveText() async {
    DocumentSnapshot docSnapshot = await _firestore.doc('Arbeitsblätter/WXoxYKcgK9xHd5B0mO5V').get();
    return docSnapshot.get('Text') as String;
  }
}
