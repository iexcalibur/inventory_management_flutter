import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final FontWeight fontWeight;
  final double fontSize;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderWidth;
  final Color? borderColor;

  const BlackButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.black,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: borderWidth != null
                  ? BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth!,
                    )
                  : BorderSide.none,
            ),
            elevation: 0,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
} 