import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceItem extends StatelessWidget {
  final String title;
  final String period;
  final bool isLast;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Color titleColor;
  final Color periodColor;
  final Color dividerColor;
  final double dividerHeight;
  final double verticalSpacing;
  final TextStyle? titleStyle;
  final TextStyle? periodStyle;

  const ExperienceItem({
    super.key,
    required this.title,
    required this.period,
    this.isLast = false,
    this.icon = Icons.work_outline,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.titleColor = Colors.white,
    this.periodColor = const Color(0xFFABABAB),
    this.dividerColor = const Color(0xFF474747),
    this.dividerHeight = 32.0,
    this.verticalSpacing = 16.0,
    this.titleStyle,
    this.periodStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          GoogleFonts.workSans(
                            color: titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: periodStyle ??
                          GoogleFonts.workSans(
                            color: periodColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    if (!isLast) SizedBox(height: verticalSpacing),
                  ],
                ),
              ),
            ],
          ),
          if (!isLast) Divider(color: dividerColor, height: dividerHeight),
        ],
      ),
    );
  }
}
