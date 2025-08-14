import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillProgressBar extends StatefulWidget {
  final String skill;
  final int percentage;
  final Color? skillTextColor;
  final Color? percentageTextColor;
  final Color? progressBackgroundColor;
  final Color? progressColor;
  final double? height;
  final double? borderRadius;
  final TextStyle? skillTextStyle;
  final TextStyle? percentageTextStyle;
  final Duration animationDuration;

  const SkillProgressBar({
    super.key,
    required this.skill,
    required this.percentage,
    this.skillTextColor = Colors.white,
    this.percentageTextColor = Colors.white,
    this.progressBackgroundColor = const Color(0xFF474747),
    this.progressColor = Colors.white,
    this.height = 4.0,
    this.borderRadius = 2.0,
    this.skillTextStyle,
    this.percentageTextStyle,
    this.animationDuration = const Duration(milliseconds: 1800),
  }) : assert(percentage >= 0 && percentage <= 100, 'Percentage must be between 0 and 100');

  @override
  State<SkillProgressBar> createState() => _SkillProgressBarState();
}

class _SkillProgressBarState extends State<SkillProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
        _animationController.reset();
        _animationController.forward();
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
        _animationController.reset();
        _animationController.forward();
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.skill,
                  style: widget.skillTextStyle ??
                      GoogleFonts.workSans(
                        color: widget.skillTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  '${widget.percentage}%',
                  style: widget.percentageTextStyle ??
                      GoogleFonts.workSans(
                        color: widget.percentageTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: widget.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.progressBackgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius!),
              ),
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _isHovered ? _progressAnimation.value : widget.percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.progressColor,
                        borderRadius: BorderRadius.circular(widget.borderRadius!),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: widget.progressColor!.withValues(alpha: 0.7),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}