import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/repos/auth_repo.dart';
import 'package:flutter_project/authentications/views/login_screen.dart';
import 'package:flutter_project/authentications/views/sign_up_screen.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';
import 'package:flutter_project/features/main/views/main_screen.dart';
import 'package:flutter_project/features/main/views/mood_write_screen.dart';
import 'package:flutter_project/features/setting/views/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (state.subloc != SignUpScreen.routePath &&
          state.subloc != LoginScreen.routePath &&
          !isLoggedIn) {
        return LoginScreen.routePath;
      }
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return child;
        },
        routes: [
          GoRoute(
            path: LoginScreen.routePath,
            name: LoginScreen.routeName,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: SignUpScreen.routePath,
            name: SignUpScreen.routeName,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            path: "/:tab(home|write)",
            name: MainScreen.routeName,
            builder: (context, state) {
              final tab = state.params["tab"]!;
              return MainScreen(tab: tab);
            },
          ),
          GoRoute(
            path: MoodWriteScreen.routePath,
            name: MoodWriteScreen.routeName,
            builder: (context, state) {
              final selectedMood = state.extra as EmotionData;
              return MoodWriteScreen(selectedMood: selectedMood);
            },
          ),
          GoRoute(
            path: SettingView.routePath,
            name: SettingView.routeName,
            builder: (context, state) => const SettingView(),
          ),
        ],
      ),
    ],
  );
});
