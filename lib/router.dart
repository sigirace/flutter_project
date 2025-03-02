import 'package:flutter_project/features/feature/views/feature_screen.dart';
import 'package:flutter_project/features/setting/views/setting_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: FeatureScreen.path,
        name: FeatureScreen.name,
        builder: (context, state) => const FeatureScreen(),
      ),
      GoRoute(
        path: SettingView.path,
        name: SettingView.name,
        builder: (context, state) => const SettingView(),
      ),
    ],
  );
});
