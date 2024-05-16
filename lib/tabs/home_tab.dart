import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monie_design/theme.dart';
import 'package:monie_design/widgets/current_location_widget.dart';
import 'package:monie_design/widgets/greeting_widget.dart';
import 'package:monie_design/widgets/houses_display_widget.dart';
import 'package:monie_design/widgets/offers_widget.dart';
import 'package:monie_design/widgets/profile_avatar_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageBackground(
        child: SafeArea(
          bottom: false,
          child: ListView(
            children: const [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: CurrentLocationWidget()),
                    ProfileAvatarWidget()
                  ],
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: UserGreetingWidget(),
              ),
              SizedBox(height: 35),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: OffersWidget(),
              ),
              SizedBox(height: 25),
              HousesDisplayWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageBackground extends StatelessWidget {
  final Widget child;

  const _PageBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, greyA5957E, orangeF28E13],
          stops: [
            0.0,
            0.5,
            0.8,
          ],
          // stops: [
          //   0.2,
          //   0.9,
          // ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.white.withOpacity(.8),
          child: child,
        ),
      ),
    );
  }
}
