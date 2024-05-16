import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';

class MapSearchWidget extends StatefulWidget {
  const MapSearchWidget({super.key});

  @override
  State<MapSearchWidget> createState() => _MapSearchWidgetState();
}

class _MapSearchWidgetState extends State<MapSearchWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650));
    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const _SearchField(),
          ),
        ),
        const SizedBox(width: 10),
        ScaleTransition(
          scale: scaleAnimation,
          child: const _FilterButton(),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/search.svg',
            height: 20,
            colorFilter: const ColorFilter.mode(
              black232220,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Saint Petersburg',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: black232220,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      child: SvgPicture.asset(
        'assets/images/filter.svg',
        height: 20,
        colorFilter: const ColorFilter.mode(
          black232220,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
