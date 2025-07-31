import 'package:flutter/material.dart';
import 'dart:ui';

class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDark 
        ? Colors.white.withOpacity(0.1)
        : Colors.white.withOpacity(0.7);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: backgroundColor ?? defaultBackgroundColor,
                borderRadius: borderRadius ?? BorderRadius.circular(20),
                border: Border.all(
                  color: isDark 
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class ZenButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final bool isLoading;

  const ZenButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = backgroundColor ?? 
        (isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.8));
    final defaultTextColor = textColor ?? 
        (isDark ? Colors.white : const Color(0xFF2C3E50));

    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: defaultBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onPressed,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(defaultTextColor),
                          ),
                        )
                      else if (icon != null) ...[
                        Icon(icon, color: defaultTextColor, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: defaultTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ZenInputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  const ZenInputField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            maxLines: maxLines,
            keyboardType: keyboardType,
            onTap: onTap,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF2C3E50),
              fontSize: 16,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon != null 
                  ? Icon(
                      prefixIcon,
                      color: isDark 
                          ? Colors.white.withOpacity(0.7)
                          : const Color(0xFF95A5A6),
                    )
                  : null,
              labelStyle: TextStyle(
                color: isDark 
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF95A5A6),
              ),
              hintStyle: TextStyle(
                color: isDark 
                    ? Colors.white.withOpacity(0.5)
                    : const Color(0xFF95A5A6).withOpacity(0.7),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 