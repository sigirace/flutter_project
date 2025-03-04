import 'package:flutter_project/authentications/views/login_screen.dart';
import 'package:flutter_project/authentications/views/sign_up_screen.dart';
import 'package:flutter_project/features/feature/views/feature_screen.dart';
import 'package:flutter_project/features/setting/views/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: FeatureScreen.routePath,
        name: FeatureScreen.routeName,
        builder: (context, state) => const FeatureScreen(),
      ),
      GoRoute(
        path: SettingView.routePath,
        name: SettingView.routeName,
        builder: (context, state) => const SettingView(),
      ),
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
    ],
  );
});
