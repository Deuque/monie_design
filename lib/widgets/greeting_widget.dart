import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class UserGreetingWidget extends StatefulWidget {
  const UserGreetingWidget({super.key});

  @override
  State<UserGreetingWidget> createState() => _UserGreetingWidgetState();
}

class _UserGreetingWidgetState extends State<UserGreetingWidget>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;
  late Animation<Offset> animation;
  late Animation<Offset> animation2;
  final textOneFuture = Future.delayed(const Duration(milliseconds: 1900));

  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    controller3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    animation =
        Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(parent: controller2,curve: Curves.decelerate));
    animation2 =
        Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(parent: controller3,curve: Curves.decelerate));
    Future.delayed(
      const Duration(milliseconds: 1100),
      controller1.forward,
    );
    Future.delayed(
      const Duration(milliseconds: 1400),
      controller2.forward,
    );
    Future.delayed(
      const Duration(milliseconds: 1500),
      controller3.forward,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: controller1,
          builder: (_, __) {
            return Opacity(
              opacity: controller1.value,
              child: const Text(
                'Hi, Marina',
                style: TextStyle(
                  fontSize: 20,
                  color: greyA5957E,
                ),
              ),
            );
          },
        ),
        Container(
          height: 45,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: SlideTransition(
            position: animation,
            child: const Text(
              'let\'s select your',
              style: TextStyle(
                fontSize: 36,
                color: black232220,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: SlideTransition(
            position: animation2,
            child: const Text(
              'perfect place',
              style: TextStyle(
                fontSize: 36,
                color: black232220,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


