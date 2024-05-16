import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget({super.key});

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    sizeAnimation = Tween(begin: 0.0, end: 47.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: sizeAnimation,
        builder: (_, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              width: sizeAnimation.value,
              height: sizeAnimation.value,
              child: SvgPicture.asset(
                'assets/images/lady.svg',
                fit: BoxFit.cover,
                height: 0,width: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
