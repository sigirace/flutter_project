import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/repos/auth_repo.dart';
import 'package:flutter_project/common/widgets/firebase_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  Future<void> build() async {
    _authRepo = ref.watch(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepo.signIn(email, password);
    });

    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error as FirebaseException);
      } else {
        context.go("/home");
      }
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepo.signOut();
    });
  }
}

final loginProvider = AsyncNotifierProvider<LogInViewModel, void>(
  () => LogInViewModel(),
);
