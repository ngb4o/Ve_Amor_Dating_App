import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';

class TActionButton extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final bool coloTransparent;
  final bool hasBorder;
  final bool hasElevation;

  const TActionButton({
    super.key,
    required this.assetPath,
    required this.color,
    required this.size,
    required this.onTap,
    this.coloTransparent =true,
    this.hasBorder = true,
    this.hasElevation = false
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: coloTransparent ? Colors.transparent : TColors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: hasBorder ? Border.all(color: color) : null,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                assetPath,
                color: color,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}