import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';

class CurrentLocationWidget extends StatefulWidget {
  const CurrentLocationWidget({super.key});

  @override
  State<CurrentLocationWidget> createState() => _CurrentLocationWidgetState();
}

class _CurrentLocationWidgetState extends State<CurrentLocationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    sizeAnimation = Tween(begin: 0.0, end: 180.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedBuilder(
        animation: sizeAnimation,
        builder: (_, child) {
          return Container(
            height: 50,
            width: sizeAnimation.value,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                sizeAnimation.value > 110 ? child! : const SizedBox(),
              ],
            ),
          );
        },
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (_, val, __) => Opacity(
            opacity: val,
            child: Row(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/images/location.svg',
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      greyA5957E,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Center(
                  child: Text(
                    'Saint Petersburg',
                    style: TextStyle(
                        color: greyA5957E, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
