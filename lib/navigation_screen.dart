import 'package:flutter/material.dart';
import 'package:monie_design/tabs/find_tab.dart';
import 'package:monie_design/tabs/home_tab.dart';
import 'package:monie_design/widgets/bottom_navigation_widget.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedTab = 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchOutCurve: Curves.easeIn,
          switchInCurve: Curves.easeOut,
          child: switch (selectedTab) {
            0 => const FindTab(),
            2 => const HomeTab(),
            _ => const SizedBox(),
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.paddingOf(context).bottom + 10,
          child: BottomNavigationWidget(
            selectedIndex: selectedTab,
            onSelect: (i) {
              setState(() {
                selectedTab = i;
              });
            },
          ),
        )
      ],
    );
  }
}
