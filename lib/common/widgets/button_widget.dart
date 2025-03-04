import 'package:flutter/material.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/sizes.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Height.h48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.size30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(1, 2),
              blurRadius: 1,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: FontSize.fs16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
