import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';

class HousesDisplayWidget extends StatefulWidget {
  const HousesDisplayWidget({super.key});

  @override
  State<HousesDisplayWidget> createState() => _HousesDisplayWidgetState();
}

class _HousesDisplayWidgetState extends State<HousesDisplayWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimation = Tween(begin: Offset(0, 2), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    Future.delayed(
      const Duration(milliseconds: 2300),
      () {
        controller.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: _HouseView(
                  houseImage: 'assets/images/house1.jpeg',
                  houseLocation: 'Gladkova St., 25',
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: _HouseView(
                        houseImage: 'assets/images/house2.jpeg',
                        houseLocation: 'Cubina',
                      ),
                    ),
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: _HouseView(
                              houseImage: 'assets/images/house4.jpeg',
                              houseLocation: 'Trefoleva ',
                            ),
                          )),
                          SizedBox(height: 8),
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: _HouseView(
                              houseImage: 'assets/images/house3.jpeg',
                              houseLocation: 'Sedova',
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HouseView extends StatefulWidget {
  final String houseImage, houseLocation;

  const _HouseView({required this.houseImage, required this.houseLocation});

  @override
  State<_HouseView> createState() => _HouseViewState();
}

class _HouseViewState extends State<_HouseView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    sizeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.decelerate,
      ),
    ));
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        controller.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = max(
            (constraints.maxWidth / MediaQuery.sizeOf(context).width) * 55,
            30.0);
        final sliderWidth = constraints.maxWidth - 20 - height;
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.houseImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: AnimatedBuilder(
                  animation: sizeAnimation,
                  builder: (context, child) {
                    return Container(
                      height: height,
                      width: height + (sliderWidth * sizeAnimation.value),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          child ?? const SizedBox(),
                          if (sizeAnimation.value > 0.9)
                            Positioned.fill(
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (_, val, __) => Opacity(
                                  opacity: val,
                                  child: Center(
                                    child: Text(
                                      widget.houseLocation,
                                      style: const TextStyle(
                                        color: black232220,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Material(
                      color: greyA5957E.withOpacity(.5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: height / 2,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.chevron_right_sharp,
                              size: 19,
                              color: greyA5957E,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
