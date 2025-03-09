import 'package:flutter/material.dart';
import 'package:flutter_project/constants/fonts.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';
import 'package:flutter_project/utils/dateutil.dart';

class MoodCardScreen extends StatelessWidget {
  final Mood mood;

  const MoodCardScreen({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    final emotionData = EmotionType.fromKey(mood.mood.toString()).data;
    final formattedDate = mood.createdAt;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withAlpha(50),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: emotionData.backgroundColor,
              borderRadius: BorderRadius.circular(Sizes.size20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -Sizes.size20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.scale(
                      scale: 3,
                      child: emotionData.emoji,
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height * 0.75) / 2 -
                      (FontSize.fs72 / 2),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.scale(
                      scale: 3,
                      child: Opacity(
                        opacity: 0.4,
                        child: emotionData.icon,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.size24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v30,
                      Center(
                        child: Text(
                          "이때의 기분은 ${emotionData.detail}",
                          style: TextStyle(
                            fontSize: FontSize.fs12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gaps.v12,
                      Text(
                        mood.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.fs20,
                          fontFamily: FontFamily.sbM,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v12,
                      Divider(
                        color: Colors.white.withAlpha(50),
                        thickness: 1,
                      ),
                      Gaps.v12,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            mood.content,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: FontSize.fs16,
                              fontFamily: FontFamily.sbM,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v16,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            Text(
                              DateUtil.formatDate(formattedDate),
                              style: TextStyle(
                                fontSize: FontSize.fs12,
                                color: Colors.white.withAlpha(70),
                              ),
                            ),
                            Text(
                              DateUtil.formatTime(formattedDate),
                              style: TextStyle(
                                fontSize: FontSize.fs12,
                                color: Colors.white.withAlpha(70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
