import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/main.export.dart';

import 'nav_destination.dart';

class NavButton extends HookWidget {
  const NavButton({
    super.key,
    required this.destination,
    required this.index,
    required this.onPressed,
    required this.selectedIndex,
    required this.count,
  });

  final KNavDestination destination;
  final int index;
  final int selectedIndex;
  final void Function()? onPressed;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 56,
              alignment: Alignment.center,
              height: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  destination.isHighlight == true
                      ? CircleAvatar(
                          backgroundColor: destination.isHighlight == true
                              ? context.colors.primary
                              : Colors.transparent,
                          radius: 25,
                          child: SvgPicture.asset(
                            height: destination.isHighlight == true ? 30 : 34,
                            destination.icon,
                            colorFilter: ColorFilter.mode(
                              destination.isHighlight == true
                                  ? context.colors.onPrimary
                                  : context.colors.shadow,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            if (selectedIndex == index)
                              RotatedBox(
                                quarterTurns: 2,
                                child: CustomPaint(
                                  size: const Size(20, 10),
                                  painter: TrianglePainter(
                                    context.colors.primary,
                                  ),
                                ),
                              ),
                            const Gap(Insets.sm),
                            SvgPicture.asset(
                              height: 29,
                              selectedIndex == index
                                  ? destination.selectIcon ?? destination.icon
                                  : destination.icon,
                              colorFilter: ColorFilter.mode(
                                selectedIndex == index
                                    ? context.colors.primary
                                    : context.colors.shadow,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
