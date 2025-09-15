import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final Color backgroundColor;
  final double borderRadius;
  final double spacing;
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final BoxFit? fit;
  final List<Widget>? actions;

  const SkillCard({
    super.key,
    required this.title,
    this.imageUrl,
    this.backgroundColor = const Color(0xFF1E1E1E),
    this.borderRadius = 8.0,
    this.spacing = 12.0,
    this.titleColor = Colors.white,
    this.titleSize = 16.0,
    this.titleWeight = FontWeight.w500,
    this.width,
    this.height,
    this.onTap,
    this.fit,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: fit ?? BoxFit.cover,
                    )
                  : null,
            ),
            child: actions != null
                ? Stack(
                    children: [
                      if (actions!.isNotEmpty)
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!,
                          ),
                        ),
                    ],
                  )
                : null,
          ),
          if (title.isNotEmpty) SizedBox(height: spacing),
          if (title.isNotEmpty)
            Text(
              title,
              style: GoogleFonts.workSans(
                color: titleColor,
                fontSize: titleSize,
                fontWeight: titleWeight,
              ),
            ),
        ],
      ),
    );
  }
}
