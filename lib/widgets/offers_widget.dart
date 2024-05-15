import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({super.key});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late Animation<double> sizeAnimation;
  late Animation<double> buyCountAnimation;
  late Animation<double> rentCountAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    sizeAnimation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    buyCountAnimation = Tween(begin: 0.0, end: 1034.0).animate(controller2);
    rentCountAnimation = Tween(begin: 0.0, end: 2212.0).animate(controller2);
    Future.delayed(
      const Duration(milliseconds: 1650),
      () {
        controller.forward();
        controller2.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: sizeAnimation,
            child: AnimatedBuilder(
                animation: buyCountAnimation,
                builder: (context, _) {
                  return _BuyCountView(
                    buyCountAnimation.value,
                  );
                }),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ScaleTransition(
            scale: sizeAnimation,
            child: AnimatedBuilder(
                animation: buyCountAnimation,
                builder: (context,_) {
                return _RentCountView(
                  rentCountAnimation.value,
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}

class _BuyCountView extends StatelessWidget {
  final double buyCount;

  const _BuyCountView(this.buyCount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CircleAvatar(
        radius: constraints.maxWidth / 2,
        backgroundColor: orangeF28E13.withOpacity(.8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            FittedBox(
              child: Text(
                'Buy',
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            FittedBox(
              child: Text(
                splitText(buyCount.toStringAsFixed(0)),
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            FittedBox(
              child: Text(
                'Offers',
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      );
    });
  }
}

class _RentCountView extends StatelessWidget {
  final double rentCount;

  const _RentCountView(this.rentCount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxWidth,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(constraints.maxWidth / 10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            FittedBox(
              child: Text(
                'Rent',
                maxLines: 1,
                style: TextStyle(color: greyA5957E),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            FittedBox(
              child: Text(
                splitText(rentCount.toStringAsFixed(0)),
                maxLines: 1,
                style: TextStyle(
                  color: greyA5957E,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            FittedBox(
              child: Text(
                'Offers',
                maxLines: 1,
                style: TextStyle(color: greyA5957E),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      );
    });
  }
}

String splitText(String text){
  if(text.length < 4){
    return text;
  }
  return '${text.substring(0,1)} ${text.substring(1)}';
}
