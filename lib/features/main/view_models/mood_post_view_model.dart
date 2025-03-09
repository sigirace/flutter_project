import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/repos/auth_repo.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_project/features/main/repos/mood_repo.dart';
import 'package:flutter_project/features/main/view_models/timeline_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

class MoodPostViewModel extends AsyncNotifier<void> {
  late final MoodRepository _moodRepo;

  @override
  FutureOr<void> build() {
    _moodRepo = ref.read(moodRepo);
  }

  Future<void> postMood(Mood mood, BuildContext context) async {
    state = const AsyncLoading();
    final user = ref.read(authRepo).user;
    await _moodRepo.post(mood, user!.uid);
    await ref.read(timelineProvider.notifier).addMood(mood);
    state = const AsyncData(null);
    if (context.mounted) {
      context.go("/home");
    }
  }
}

final moodPostProvider = AsyncNotifierProvider<MoodPostViewModel, void>(
  () => MoodPostViewModel(),
);
