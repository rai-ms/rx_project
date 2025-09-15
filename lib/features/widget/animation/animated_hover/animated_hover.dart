import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;

  const HoverCard({
    super.key,
    required this.child,
    this.width = 300,
    this.height = 200,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: _isHovered ? 0 : 12, // "lift up" on hover
        ),
        transform: _isHovered
            ? (Matrix4.identity()
          ..translate(0.0, -12.0)
          ..scale(1.1))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            )
          ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
