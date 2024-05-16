import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';
import 'package:monie_design/widgets/current_location_widget.dart';
import 'package:monie_design/widgets/greeting_widget.dart';
import 'package:monie_design/widgets/houses_display_widget.dart';
import 'package:monie_design/widgets/map_action_buttons_widget.dart';
import 'package:monie_design/widgets/offers_widget.dart';
import 'package:monie_design/widgets/profile_avatar_widget.dart';
import 'package:monie_design/widgets/map_search_widget.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class FindTab extends StatefulWidget {
  const FindTab({super.key});

  @override
  State<FindTab> createState() => _FindTabState();
}

class _FindTabState extends State<FindTab> {
  final toolTipController = TooltipController();

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      overlayColor: Colors.transparent,
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 0),
      controller: toolTipController,
      preferredOverlay: GestureDetector(
        onTap: () {
          toolTipController.dismiss();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
        ),
      ),
      builder: (_) {
        return  Scaffold(
          body: _PageBackground(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: MapSearchWidget(),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, MediaQuery.paddingOf(context).bottom+95),
                    child:const MapActionButtonsWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PageBackground extends StatelessWidget {
  final Widget child;

  const _PageBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/map.svg',
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
