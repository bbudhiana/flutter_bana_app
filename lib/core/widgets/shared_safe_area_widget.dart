import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class SharedSafeAreaWidget extends StatelessWidget {
  final Color color;
  final Widget child;
  final bool top;
  final bool bottom;

  const SharedSafeAreaWidget({
    super.key,
    required this.child,
    this.color = SharedColors.homerBankPrimaryColor,
    this.top = false,
    this.bottom = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        top: top,
        bottom: bottom,
        child: child,
      ),
    );
  }
}
