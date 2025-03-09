import 'package:flutter/material.dart';
import 'package:flutter_project/constants/colors.dart';
import 'package:flutter_project/constants/fonts.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';
import 'package:flutter_project/features/main/views/mood_write_screen.dart';
import 'package:go_router/go_router.dart';

class MoodSelectScreen extends StatefulWidget {
  const MoodSelectScreen({super.key});

  @override
  State<MoodSelectScreen> createState() => _MoodSelectScreenState();
}

class _MoodSelectScreenState extends State<MoodSelectScreen> {
  final FixedExtentScrollController _controller = FixedExtentScrollController(
    initialItem: 4,
  );
  double _currentIndex = 0.0;
  final double itemExtent = Sizes.size100 + Sizes.size50;
  final double baseMargin = Sizes.size10;

  final List<EmotionType> emotionList = EmotionType.values;

  @override
  void initState() {
    super.initState();
    _currentIndex = _controller.initialItem.toDouble();
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.offset / itemExtent;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    _controller.animateTo(
      index * itemExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateWithSelectedMood(int selectedIndex) {
    final selectedMood = emotionList[selectedIndex].data;

    context.pushNamed(MoodWriteScreen.routeName, extra: selectedMood);
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = _controller.hasClients
        ? _controller.selectedItem
        : _controller.initialItem;
    if (selectedIndex < 0) selectedIndex = 0;
    if (selectedIndex >= emotionList.length) {
      selectedIndex = emotionList.length - 1;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientColors,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizes.size20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "기분을 선택해 주세요",
                    style: TextStyle(
                      fontSize: FontSize.fs20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: ListWheelScrollView.useDelegate(
                          controller: _controller,
                          itemExtent: itemExtent,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: emotionList.length,
                            builder: (context, index) {
                              final diff = (_currentIndex - index).abs();
                              final scale = diff < 0.2 ? 1.3 : 1.0;
                              final extraMargin = (scale - 1.0) * 5;
                              final totalMargin = baseMargin + extraMargin;

                              final emotionData = emotionList[index].data;

                              return RotatedBox(
                                quarterTurns: -1,
                                child: GestureDetector(
                                  onTap: () => _scrollToIndex(index),
                                  child: Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: totalMargin,
                                      ),
                                      alignment: Alignment.center,
                                      width: itemExtent,
                                      height: itemExtent,
                                      decoration: BoxDecoration(
                                        color: emotionData.backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(Sizes.size16),
                                      ),
                                      child: Transform.scale(
                                        scale: 3,
                                        child: emotionData.emoji,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    emotionList[selectedIndex].data.detail,
                    style: TextStyle(
                      fontSize: FontSize.fs32,
                      fontFamily: FontFamily.sbM,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: TextButton(
              onPressed: () => _navigateWithSelectedMood(selectedIndex),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '작성하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.fs16,
                  fontFamily: FontFamily.sbM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
