import 'package:flutter/material.dart';
import 'package:monie_design/home_page.dart';
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
        HomePage(),
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
