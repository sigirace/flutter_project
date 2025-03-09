import 'package:flutter/material.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/views/widgets/icon_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationWidget extends ConsumerWidget {
  final List<IconButtonWidget> icons;

  const BottomNavigationWidget({
    super.key,
    required this.icons,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        vertical: Sizes.size30,
      ),
      child: Container(
        height: Height.h60,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size40),
          color: Colors.white.withValues(alpha: 0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: icons,
        ),
      ),
    );
  }
}
