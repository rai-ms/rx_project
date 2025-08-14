import 'package:flutter/material.dart';

class ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;
  final double? trailingIconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  /// Total duration of the "run once" border animation.
  final Duration animationDuration;

  /// Custom colors for the running border (defaults to cyan → magenta → yellow).
  final List<Color>? neonColors;

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
    this.animationDuration = const Duration(milliseconds: 1500),
    this.neonColors,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  late final AnimationController _controller;
  late final Animation<Color?> _colorSequence;

  // Colors used for the running border.
  late final List<Color> _colors;

  // The color currently shown on the border & accents.
  Color _currentBorderColor = Colors.transparent;

  final List<Color> _defaultNeonColors = const [
    Color(0xFF00F0FF), // Cyan
    Color(0xFF00F0FF), // Cyan
    Color(0xFF00F0FF), // Cyan
  ];

  @override
  void initState() {
    super.initState();

    _colors = widget.neonColors ?? _defaultNeonColors;

    // Build a sequence that walks through all colors, then ends at white.
    // e.g. c0 -> c1 -> c2 -> white
    final items = <TweenSequenceItem<Color?>>[];
    for (var i = 0; i < _colors.length - 1; i++) {
      items.add(
        TweenSequenceItem(
          tween: ColorTween(begin: _colors[i], end: _colors[i + 1]),
          weight: 1.0,
        ),
      );
    }
    // Last leg: last color -> white
    items.add(
      TweenSequenceItem(
        tween: ColorTween(begin: _colors.last, end: Colors.white),
        weight: 1.0,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _colorSequence = TweenSequence<Color?>(items).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {
          _currentBorderColor = _colorSequence.value ?? Colors.white;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && _isHovered) {
          // After one full run, hold white while still hovered.
          setState(() => _currentBorderColor = Colors.white);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (isHovered) {
        // Play once from start.
        _controller.forward(from: 0);
      } else {
        // Reset to no border on exit.
        _controller.stop();
        _controller.reset();
        _currentBorderColor = Colors.transparent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    return  ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: 500
      ),
      child:MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: Card(
          margin: widget.margin ??
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: _isHovered ? 4.0 : 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: _isHovered ? _currentBorderColor : Colors.transparent,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: borderRadius,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                // Subtle glow that matches the current border color while hovered.
                gradient: _isHovered
                    ? LinearGradient(
                  colors: [
                    _currentBorderColor.withOpacity(0.10),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
                    : null,
              ),
              child: ListTile(
                leading: Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: _isHovered ? _currentBorderColor : null,
                ),
                title: Text(
                  widget.title,
                  style: (widget.titleStyle ??
                      const TextStyle(fontWeight: FontWeight.bold))
                      .copyWith(
                    color: _isHovered ? _currentBorderColor : null,
                  ),
                ),
                subtitle: Text(
                  widget.subtitle,
                  style: widget.subtitleStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: widget.trailingIconSize,
                  color: _isHovered ? _currentBorderColor : null,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
