import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';

class BottomNavigationWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const BottomNavigationWidget(
      {super.key, required this.selectedIndex, required this.onSelect});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  final icons = [
    'assets/images/nav_search.svg',
    'assets/images/nav_chat.svg',
    'assets/images/nav_home.svg',
    'assets/images/nav_fav.svg',
    'assets/images/nav_profile.svg'
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    slideAnimation = Tween(begin: const Offset(0, 2), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    Future.delayed(
      const Duration(milliseconds: 4000),
      () {
        if (mounted) {
          controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: black232220,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final (i, a) in icons.indexed)
                  Padding(
                    padding:
                        EdgeInsets.only(right: i < icons.length - 1 ? 12 : 0),
                    child: GestureDetector(
                      onTap: () {
                        widget.onSelect(i);
                      },
                      child: _NavIcon(
                          selected: i == widget.selectedIndex, assetPath: a),
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final bool selected;
  final String assetPath;

  const _NavIcon({required this.selected, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final boxSize = selected ? 50.0 : 40.0;
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 400),
      height: boxSize,
      width: boxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
        color: selected ? orangeF28E13 : Colors.black,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        assetPath,
        height: 20,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
