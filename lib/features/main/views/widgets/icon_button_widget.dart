import 'package:flutter/material.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconButtonWidget extends StatelessWidget {
  final void Function() callback;
  final FaIcon icon;
  final double? paddingSize;
  final double? iconSize;

  const IconButtonWidget({
    super.key,
    required this.callback,
    required this.icon,
    this.paddingSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: Padding(
        padding: EdgeInsets.all(
          paddingSize ?? Sizes.size10,
        ),
        child: icon,
      ),
    );
  }
}
