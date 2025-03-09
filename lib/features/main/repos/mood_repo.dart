import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> post(Mood mood, String userId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('moods')
        .add(mood.toJson());
  }

  Future<void> deleteMood(String moodId, String userId) async {
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('moods')
        .where('id', isEqualTo: moodId)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoods({
    required String userId,
    int? lastCreatedAt,
  }) async {
    Query<Map<String, dynamic>> query = _db
        .collection('users')
        .doc(userId)
        .collection('moods')
        .orderBy('createdAt', descending: true)
        .limit(5);

    if (lastCreatedAt != null) {
      query = query.startAfter([lastCreatedAt]);
    }

    return query.get();
  }
}

final moodRepo = Provider<MoodRepository>((ref) {
  return MoodRepository();
});
