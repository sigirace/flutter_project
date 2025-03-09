import 'package:flutter/material.dart';
import 'package:flutter_project/constants/colors.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/views/widgets/icon_button_widget.dart';
import 'package:flutter_project/features/setting/views/setting_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final double threshold;

  const SliverHeader({
    required this.threshold,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final factor = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    Color backgroundColor =
        shrinkOffset < threshold ? Colors.transparent : Colors.white;

    final startTextColor = Color.lerp(
      Colors.white,
      AppColors.firstColor,
      factor,
    )!;
    final endTextColor = Color.lerp(
      Colors.white,
      AppColors.secondColor,
      factor,
    )!;
    final textGradient = LinearGradient(
      colors: [startTextColor, endTextColor],
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Gaps.v36,
          Expanded(
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return textGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  );
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  '에프로움',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: factor < 0.5 ? FontSize.fs50 : FontSize.fs24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          if (factor < 0.5)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtonWidget(
                  icon: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: Colors.white,
                  ),
                  iconSize: Sizes.size20,
                  callback: () {},
                ),
                IconButtonWidget(
                  icon: const FaIcon(
                    FontAwesomeIcons.gear,
                    color: Colors.white,
                  ),
                  iconSize: Sizes.size20,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingView(),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
