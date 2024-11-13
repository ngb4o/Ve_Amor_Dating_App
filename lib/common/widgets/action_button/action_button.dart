import 'package:flutter/material.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

class TActionButton extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final bool coloTransparent;
  final bool hasBorder;
  final bool hasElevation;
  final bool hasBorderRadius;

  const TActionButton({
    super.key,
    required this.assetPath,
    required this.color,
    required this.size,
    required this.onTap,
    this.coloTransparent = true,
    this.hasBorder = true,
    this.hasElevation = false,
    this.hasBorderRadius = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: size ,
      height: size ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: coloTransparent ? Colors.transparent :(dark ? TColors.backgroundActionButtonDarkColor: TColors.white),
        elevation: hasElevation ? 4 : 0,
        borderRadius: hasBorderRadius ? BorderRadius.circular(100) : null,
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
      ),
    );
  }
}
