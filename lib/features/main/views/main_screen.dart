import 'package:flutter/material.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/main/views/mood_sreen.dart';
import 'package:flutter_project/features/main/views/mood_select_screen.dart';
import 'package:flutter_project/features/main/views/widgets/bottom_navigation_widget.dart';
import 'package:flutter_project/features/main/views/widgets/icon_button_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';
  final String tab;
  const MainScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _tabs = [
    "home",
    "write",
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _tabs.indexOf(widget.tab);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tab != oldWidget.tab) {
      setState(() {
        _selectedIndex = _tabs.indexOf(widget.tab);
      });
    }
  }

  void _onNavTabBar(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const MoodScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const MoodSelectScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        icons: [
          IconButtonWidget(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: _selectedIndex == 0 ? Colors.black : Colors.grey.shade700,
            ),
            callback: () => _onNavTabBar(0),
            paddingSize: Sizes.size0,
          ),
          IconButtonWidget(
            icon: FaIcon(
              FontAwesomeIcons.penToSquare,
              color: _selectedIndex == 1 ? Colors.black : Colors.grey.shade700,
            ),
            callback: () => _onNavTabBar(1),
            paddingSize: Sizes.size0,
          ),
        ],
      ),
    );
  }
}
