import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/setting/repos/setting_repo.dart';
import 'package:flutter_project/features/setting/view_models/mode_view_model.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preference = await SharedPreferences.getInstance();
  final repository = SettingRepository(preference);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ProviderScope(
      overrides: [
        modeViewModelProvider.overrideWith(
          () => ModeViewModel(repository),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter Project',
          themeMode: ref.watch(modeViewModelProvider).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFECE6C2),
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Color(0xFFECE6C2),
              backgroundColor: Color(0xFFECE6C2),
              foregroundColor: Colors.black,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.size20,
                color: Colors.black,
              ),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Color(0xFFECE6C2),
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              elevation: 0,
              color: Color(0xFFECE6C2),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: Colors.black54,
                fontSize: FontSize.fs16,
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontSize: FontSize.fs20,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFF4E98E9),
            ),
            primaryColor: const Color(0xFFFEA6F6),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              surfaceTintColor: Colors.black,
              backgroundColor: Colors.black,
              foregroundColor: Colors.grey.shade400,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.size20,
                color: Colors.grey.shade400,
              ),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.black,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              elevation: 0,
              color: Colors.black,
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: Colors.black54,
                fontSize: FontSize.fs16,
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontSize: FontSize.fs20,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFF4E98E9),
            ),
            primaryColor: const Color.fromARGB(255, 22, 128, 241),
            useMaterial3: true,
          ),
          routerConfig: ref.watch(routerProvider),
        );
      },
    );
  }
}
