import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/constants/colors.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';
import 'package:flutter_project/features/main/view_models/timeline_view_model.dart';
import 'package:flutter_project/features/main/views/mood_card_screen.dart';
import 'package:flutter_project/features/main/views/widgets/mood_widget.dart';
import 'package:flutter_project/features/main/views/widgets/sliver_header.dart';
import 'package:flutter_project/utils/dateutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodScreen extends ConsumerStatefulWidget {
  const MoodScreen({
    super.key,
  });

  @override
  ConsumerState<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends ConsumerState<MoodScreen> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0.0;
  final double threshold = 150.0;
  bool isBottomReached = false;
  bool isFetching = false;
  bool canFetchMore = false;
  ScrollDirection lastScrollDirection = ScrollDirection.idle;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
        lastScrollDirection = _scrollController.position.userScrollDirection;

        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
          isBottomReached = true;
          canFetchMore = true;
        } else if (canFetchMore &&
            lastScrollDirection == ScrollDirection.reverse) {
          canFetchMore = false;
          fetchMoreData();
        } else {
          isBottomReached = false;
          canFetchMore = false;
        }
      });
    });
  }

  Future<void> fetchMoreData() async {
    if (isFetching) return;
    setState(() {
      isFetching = true;
    });

    await ref.read(timelineProvider.notifier).fetchMore();

    setState(() {
      isFetching = false;
      canFetchMore = false;
      isBottomReached = false;
    });
  }

  void _deleteMood(Mood mood) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "기분 삭제",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "이때의 기분을 삭제하시겠습니까?",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(),
              TextButton(
                onPressed: () async {
                  await ref.read(timelineProvider.notifier).delete(mood);
                  final data = ref.read(timelineProvider);

                  if (data is AsyncData && data.value!.length < 5) {
                    await ref.read(timelineProvider.notifier).fetchMore();
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text("삭제", style: TextStyle(fontSize: 18)),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("취소", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToMoodCard(Mood mood) {
    {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              MoodCardScreen(
            mood: mood,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  LinearGradient getBackgroundGradient() {
    double factor = (scrollOffset / threshold).clamp(0.0, 1.0);
    Color firstColor = Color.lerp(
      AppColors.firstColor,
      Colors.white,
      factor,
    )!;
    Color secondColor = Color.lerp(
      AppColors.secondColor,
      Colors.white,
      factor,
    )!;

    return LinearGradient(
      colors: [firstColor, secondColor],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: getBackgroundGradient(),
      ),
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                delegate: SliverHeader(
                  threshold: threshold,
                ),
                pinned: true,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.size50),
                      topRight: Radius.circular(Sizes.size50),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Height.h24,
                      left: Width.w24,
                      right: Width.w24,
                      bottom: Height.h100,
                    ),
                    child: ref.watch(timelineProvider).when(
                          loading: () => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          error: (error, stackTrace) => const Center(
                            child: Text("Error"),
                          ),
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(
                                child: Text("오늘의 기분을 작성해보세요!"),
                              );
                            }
                            return Column(
                              children: [
                                ...List.generate(
                                  data.length * 2 - 1,
                                  (index) {
                                    if (index.isOdd) {
                                      return Gaps.v24;
                                    } else {
                                      return MoodWidget(
                                        onTap: () {
                                          _navigateToMoodCard(
                                            data[index ~/ 2],
                                          );
                                        },
                                        onLongPress: () {
                                          _deleteMood(data[index ~/ 2]);
                                        },
                                        emotionType: EmotionType.fromKey(
                                          data[index ~/ 2].mood.toString(),
                                        ),
                                        title: data[index ~/ 2].title,
                                        subtitle: data[index ~/ 2].content,
                                        date: DateUtil.formatDate(
                                          data[index ~/ 2].createdAt,
                                        ),
                                        time: DateUtil.formatTime(
                                          data[index ~/ 2].createdAt,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                if (isFetching)
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CupertinoActivityIndicator(),
                                  ),
                              ],
                            );
                          },
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
