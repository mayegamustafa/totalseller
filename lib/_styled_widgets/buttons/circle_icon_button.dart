import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.iconData,
    required this.color,
    this.onTap,
    this.child,
  });
  final void Function()? onTap;
  final IconData iconData;
  final Color color;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: color.withOpacity(.1),
        child: child ??
            Icon(
              iconData,
              size: 18,
              color: color,
            ),
      ),
    );
  }
}
