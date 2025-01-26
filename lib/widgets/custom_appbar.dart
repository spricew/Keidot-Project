import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolbarHeight;
  final Color backgroundColor;
  final Color titleColor;
  final double titleFontSize; // Nuevo atributo
  final Color iconColor;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.toolbarHeight = 90,
    this.backgroundColor = Colors.amberAccent,
    this.titleColor = darkGreen,
    this.titleFontSize = 28, // Valor por defecto
    this.iconColor = darkGreen,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          letterSpacing: -0.8,
          fontWeight: FontWeight.w500,
          fontSize: titleFontSize, // Usar el nuevo atributo
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
