import 'dart:async';

import 'package:flutter_project/authentications/repos/auth_repo.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_project/features/main/repos/mood_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<Mood>> {
  late final MoodRepository _moodRepo;
  List<Mood> _moods = [];

  @override
  FutureOr<List<Mood>> build() async {
    _moodRepo = ref.read(moodRepo);
    _moods = await _fetchMoods(lastCreatedAt: null);
    return _moods;
  }

  Future<List<Mood>> _fetchMoods({int? lastCreatedAt}) async {
    final userId = ref.read(authRepo).user!.uid;
    final result = await _moodRepo.fetchMoods(
      userId: userId,
      lastCreatedAt: lastCreatedAt,
    );
    final moods = result.docs.map((doc) => Mood.fromJson(doc.data())).toList();
    return moods;
  }

  Future<void> fetchMore() async {
    if (_moods.isEmpty) return;

    final lastMood = _moods.last;
    await Future.delayed(const Duration(seconds: 1));
    final moods = await _fetchMoods(lastCreatedAt: lastMood.createdAt);
    _moods = [..._moods, ...moods];
    state = AsyncValue.data(_moods);
  }

  Future<void> addMood(Mood mood) async {
    _moods = [mood, ..._moods];
    state = AsyncValue.data(_moods);
  }

  Future<void> refresh() async {
    final moods = await _fetchMoods(lastCreatedAt: null);
    _moods = [...moods, ..._moods];
    state = AsyncValue.data(_moods);
  }

  Future<void> delete(Mood mood) async {
    await Future.delayed(const Duration(seconds: 1));
    await _moodRepo.deleteMood(mood.id, ref.read(authRepo).user!.uid);
    _moods = _moods.where((m) => m.id != mood.id).toList();
    state = AsyncValue.data(_moods);
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineViewModel, List<Mood>>(
  () => TimelineViewModel(),
);
