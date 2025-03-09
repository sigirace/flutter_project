import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/models/user.dart';
import 'package:flutter_project/authentications/repos/auth_repo.dart';
import 'package:flutter_project/common/widgets/firebase_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        await _authRepo.signUp(
          ref.read(signUpForm),
        );
      },
    );
    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error as FirebaseException);
      } else {
        context.go("/home");
      }
    }
  }
}

final signUpForm = StateProvider<UserData>((ref) => UserData());

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
