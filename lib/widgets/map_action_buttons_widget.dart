import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monie_design/theme.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class MapActionButtonsWidget extends StatefulWidget {
  const MapActionButtonsWidget({super.key});

  @override
  State<MapActionButtonsWidget> createState() => _MapActionButtonsWidgetState();
}

class _MapActionButtonsWidgetState extends State<MapActionButtonsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  SelectionModel selection = SelectionModel.price;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScaleTransition(
          scale: scaleAnimation,
          child: GestureDetector(
            onTap: () {
              OverlayTooltipScaffold.of(context)?.controller.start(0);
            },
            child: OverlayTooltipItem(
              displayIndex: 0,
              tooltipVerticalPosition: TooltipVerticalPosition.TOP,
              tooltip: (controller) {
                return SelectionPopup(
                  model: selection,
                  onSelect: (s) {
                    setState(() {
                      selection = s;
                    });
                    OverlayTooltipScaffold.of(context)?.controller.dismiss();
                  },
                );
              },
              child:  _ActionItem(
                iconAsset: selection.assetPath,
                label: '',
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleTransition(
              scale: scaleAnimation,
              child: const _ActionItem(
                iconAsset: 'assets/images/send.svg',
                label: '',
                iconSize: 25,
              ),
            ),
            const SizedBox(width: 10),
            ScaleTransition(
              scale: scaleAnimation,
              child: const _ActionItem(
                iconAsset: 'assets/images/list.svg',
                label: 'List of variants',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String iconAsset, label;
  final double iconSize;

  const _ActionItem({
    required this.iconAsset,
    required this.label,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: label.isEmpty ? 50 : null,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: label.isEmpty ? Alignment.center : null,
      padding: label.isEmpty
          ? EdgeInsets.zero
          : const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            height: iconSize,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SelectionPopup extends StatelessWidget {
  final SelectionModel model;
  final Function(SelectionModel) onSelect;

  const SelectionPopup({
    super.key,
    required this.model,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0,end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      builder: (context,val,__) {
        return ScaleTransition(
          scale: AlwaysStoppedAnimation(val),
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
            margin: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: SelectionModel.values.map((e) {
                final selected = model == e;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onSelect(e);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          e.assetPath,
                          colorFilter: ColorFilter.mode(
                            selected ? orangeF28E13 : greyA5957E,
                            BlendMode.srcIn,
                          ),
                          height: 14,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          e.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected ? orangeF28E13 : greyA5957E,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }
    );
  }
}

enum SelectionModel {
  cosyArea(assetPath: 'assets/images/verified.svg', title: 'Cosy areas'),
  price(assetPath: 'assets/images/wallet.svg', title: 'Price'),
  infrastructure(
      assetPath: 'assets/images/basket.svg', title: 'Infrastructure'),
  layer(assetPath: 'assets/images/layer.svg', title: 'Without any layer');

  final String title, assetPath;

  const SelectionModel({required this.title, required this.assetPath});
}
