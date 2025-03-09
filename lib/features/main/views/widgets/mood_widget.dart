import 'package:flutter/material.dart';
import 'package:flutter_project/constants/fonts.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';

class MoodWidget extends StatelessWidget {
  final void Function() onTap;
  final void Function() onLongPress;
  final EmotionType emotionType;
  final String title;
  final String subtitle;
  final String date;
  final String time;

  const MoodWidget({
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.emotionType,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: emotionType.data.backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.size20),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 2),
                  blurRadius: 1,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: -Width.w20,
                  child: emotionType.data.icon,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                  ),
                  child: ListTile(
                    leading: emotionType.data.emoji,
                    title: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FontSize.fs14,
                        fontFamily: FontFamily.sbM,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(
                        top: Height.h5,
                      ),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: FontSize.fs12,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: FontSize.fs10,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: FontSize.fs10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
