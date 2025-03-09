import 'package:flutter/material.dart';
import 'package:flutter_project/constants/colors.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/setting/view_models/mode_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(modeViewModelProvider).isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Height.h48,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? AppColors.darkGradientColors
                : AppColors.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.size30),
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.purple : Colors.black,
              offset: const Offset(1, 2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: FontSize.fs16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
