import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderWidth;

  const SkillChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.borderWidth = 1.5,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  final List<Color> _borderColors = [
    Colors.blue,
    Colors.purple,
    Colors.cyan,
  ];
  Color _currentBorderColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        final value = _animationController.value;
        final colorIndex = (value * _borderColors.length).floor() % _borderColors.length;
        setState(() {
          _currentBorderColor = _borderColors[colorIndex];
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (isHovered) {
      _animationController.forward().then((_) {
        if (mounted) {
          setState(() {
            _currentBorderColor = Colors.white;
          });
        }
      });
    } else {
      _animationController.reset();
      setState(() {
        _currentBorderColor = Colors.transparent;
      });
    }
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? const Color(0xFF303030),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? _currentBorderColor : Colors.transparent,
            width: widget.borderWidth,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: _currentBorderColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.workSans(
            color: widget.textColor ?? Colors.white,
            fontSize: widget.fontSize ?? 14,
            fontWeight: widget.fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}