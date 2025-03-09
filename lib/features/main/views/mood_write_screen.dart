import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/fonts.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/models/mood.dart';
import 'package:flutter_project/features/main/models/mood_types.dart';
import 'package:flutter_project/features/main/view_models/mood_post_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class MoodWriteScreen extends ConsumerStatefulWidget {
  static const routePath = '/mood-write';
  static const routeName = 'mood-write';
  final EmotionData selectedMood;
  const MoodWriteScreen({super.key, required this.selectedMood});

  @override
  ConsumerState<MoodWriteScreen> createState() => _MoodWriteScreenState();
}

class _MoodWriteScreenState extends ConsumerState<MoodWriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _contentFocusNode.addListener(() {
      setState(() {});
    });
    _titleFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveMood() async {
    FocusScope.of(context).unfocus();

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("제목과 내용을 모두 입력해주세요."),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    final Mood mood = Mood(
      id: const Uuid().v4(),
      mood: widget.selectedMood.key,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    ref.read(moodPostProvider.notifier).postMood(mood, context);
  }

  @override
  Widget build(BuildContext context) {
    // bool showGap = !_contentFocusNode.hasFocus && !_titleFocusNode.hasFocus;
    final isLoading = ref.watch(moodPostProvider).isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Sizes.size16),
            child: TextButton(
              onPressed: isLoading ? null : _saveMood, // 로딩 중일 때 비활성화
              style: TextButton.styleFrom(
                backgroundColor: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
              child: Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.fs16,
                  fontFamily: FontFamily.sbM,
                ),
              ),
            ),
          ),
        ],
        title: widget.selectedMood.emoji,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: widget.selectedMood.backgroundColor,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Sizes.size16,
                  right: Sizes.size16,
                  top: MediaQuery.of(context).padding.top + kToolbarHeight + 16,
                  bottom: Sizes.size16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "제목을 입력하세요",
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        focusNode: _contentFocusNode,
                        autocorrect: false,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: "내용을 입력하세요",
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    Gaps.v30,
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withAlpha(50),
                  child: const Center(
                    child: CupertinoActivityIndicator(radius: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
