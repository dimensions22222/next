// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// 
// git commit -m "next"
// git push origin main


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle, // ✅ made optional
    this.isOutlined = false,
    this.enabled = true,
    this.color = const Color(0xFF0D47A1),
    this.textColor = Colors.white,
    this.width = 340,
    this.height = 50,
    this.borderRadius = 30,
    this.elevation = 2, // ✅ default slight shadow
    this.icon,
    this.iconOnRight = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool enabled;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final double elevation;
  final Widget? icon;
  final bool iconOnRight;
  final TextStyle? textStyle; // ✅ added properly

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = isOutlined
        ? OutlinedButton.styleFrom(
            minimumSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide(
              color: enabled ? color : Colors.grey.shade300,
              width: 1.3,
            ),
            backgroundColor: Colors.white,
          )
        : ElevatedButton.styleFrom(
            minimumSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: enabled
                ? color
                : const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5),
            elevation: elevation,
            shadowColor: Colors.black26,
          );

    final Widget label = Text(
      text,
      style: textStyle ??
          TextStyle( // ✅ uses custom or fallback style
            color: enabled ? (isOutlined ? color : textColor) : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
    );

    final Widget content = icon == null
        ? label
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: iconOnRight
                ? [label, const SizedBox(width: 6), icon!]
                : [icon!, const SizedBox(width: 6), label],
          );

    return Opacity(
      opacity: enabled ? 1 : 0.7,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: isOutlined
            ? OutlinedButton(onPressed: onPressed, style: style, child: content)
            : ElevatedButton(onPressed: onPressed, style: style, child: content),
      ),
    );
  }
}
