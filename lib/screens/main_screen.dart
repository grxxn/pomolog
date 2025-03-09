import 'package:flutter/material.dart';
import 'package:pomolog/screens/pomo_screen.dart';
import 'package:pomolog/screens/record_screen.dart';
import 'package:pomolog/screens/setting_screen.dart';
import 'package:pomolog/widgets/bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTabIndex = 0;

  void _onTabBottomNavigation(int index) {
    setState(() {
      _tabController.animateTo(index);
      currentTabIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PomoScreen(),
            RecordScreen(),
            SettingScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        currTabIdx: currentTabIndex,
        onTab: _onTabBottomNavigation,
      ),
    );
  }
}
