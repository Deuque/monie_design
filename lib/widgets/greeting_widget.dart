import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monie_design/theme.dart';

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
    controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(
            CurvedAnimation(parent: controller2, curve: Curves.decelerate));
    animation2 = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(
            CurvedAnimation(parent: controller3, curve: Curves.decelerate));
    Future.delayed(
      const Duration(milliseconds: 900),
      () {
        if (mounted) {
          controller1.forward();
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1400),
      () {
        if (mounted) {
          controller2.forward();
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        if (mounted) {
          controller3.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
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
                  fontWeight: FontWeight.w500,
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
