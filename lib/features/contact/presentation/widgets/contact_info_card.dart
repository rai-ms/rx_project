import 'package:flutter/material.dart';

class ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;
  final double? trailingIconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.margin,
    this.iconSize = 32,
    this.trailingIconSize = 16,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.0),
        child: ListTile(
          leading: Icon(icon, size: iconSize),
          title: Text(
            title,
            style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: subtitleStyle,
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: trailingIconSize),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }
}
