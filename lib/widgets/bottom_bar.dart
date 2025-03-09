import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int currTabIdx;
  final void Function(int) onTab;

  const BottomBar({super.key, required this.currTabIdx, required this.onTab});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currTabIdx,
      onTap: widget.onTab,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.timer_sharp,
              size: 17,
            ),
            label: "뽀모"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
              size: 17,
            ),
            label: "기록"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_sharp,
              size: 17,
            ),
            label: "설정"),
      ],
      selectedFontSize: 11,
      unselectedFontSize: 11,
      selectedItemColor: Colors.red.shade600,
    );
  }
}
