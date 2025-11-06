import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;
  final Color? cardColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.cardColor = const Color(0xFF1E1E1E),
    this.textColor = Colors.white,
    this.width = 300,
    this.height = 200,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false; // visual state (hover/pop-up shown)
  Timer? _autoHideTimer;

  // treat narrow screens as "touch" mobile browsers (you can tweak breakpoint)
  bool get _isTouchDevice {
    final w = MediaQuery.of(context).size.width;
    return w < 700; // consider <700px as mobile/tablet in browser
  }

  void _showHover({Duration? autoHideAfter}) {
    _autoHideTimer?.cancel();
    setState(() => _isHovered = true);
    if (autoHideAfter != null) {
      _autoHideTimer = Timer(autoHideAfter, () {
        if (mounted) setState(() => _isHovered = false);
      });
    }
  }

  void _hideHover() {
    _autoHideTimer?.cancel();
    if (mounted) setState(() => _isHovered = false);
  }

  Future<void> _performPrimaryAction() async {
    // default action - open project url or call provided onTap
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }
    final url = widget.project.projectUrl;
    if (url != null && url.trim().isNotEmpty) {
      final uri = Uri.parse(url);
      await launchUrl(uri);
    }
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final showOverlay = _isHovered;
    // animation params
    const duration = Duration(milliseconds: 250);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        // desktop: show on hover
        if (!_isTouchDevice) _showHover();
      },
      onExit: (_) {
        if (!_isTouchDevice) _hideHover();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) {
          // on touch devices, give immediate feedback on press (optional)
          if (_isTouchDevice) {
            // show pop-up immediately, auto-hide after 3s
            if (!_isHovered) {
              _showHover(autoHideAfter: const Duration(seconds: 3));
            }
            // if already hovered, we let onTap handle navigation
          }
        },
        onTap: () {
          if (_isTouchDevice) {
            // Mobile browser behaviour:
            // - If pop-up isn't shown: first tap -> show pop-up (do NOT navigate)
            // - If pop-up already shown: second tap -> navigate / perform action
            if (!_isHovered) {
              _showHover(autoHideAfter: const Duration(seconds: 3));
              return; // consume this tap: just revealed overlay
            } else {
              // overlay is visible => treat tap as confirm -> navigate
              _performPrimaryAction();
              _hideHover(); // optional: hide after navigation
              return;
            }
          } else {
            // Desktop: tap should immediately perform primary action
            _performPrimaryAction();
          }
        },
        onTapCancel: () {
          // if user cancelled touch, don't leave it hovered forever
          if (_isTouchDevice) {
            _autoHideTimer?.cancel();
            // keep visible until timer hides it (do nothing) OR hide immediately:
            // setState(() => _isHovered = false);
          }
        },
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..scale(showOverlay ? 1.08 : 1.0)
            ..translate(0.0, showOverlay ? -6.0 : 0.0),
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: widget.cardColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(showOverlay ? 0.5 : 0.25),
                blurRadius: showOverlay ? 24 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: widget.project.imageUrl != null
                    ? Image.asset(
                        widget.project.imageUrl!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
                      )
                    : Container(
                        color: Colors.grey[900],
                        child: _buildPlaceholderIcon(),
                      ),
              ),

              // overlay for readability
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showOverlay ? 0.72 : 0.32,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Title + description
              Positioned(
                left: 16,
                right: 16,
                bottom: showOverlay ? 90 : 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: GoogleFonts.workSans(
                        color: widget.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.project.description,
                      style: GoogleFonts.workSans(
                        color: widget.textColor!.withOpacity(0.85),
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // technologies block (slides up on show)
              AnimatedPositioned(
                duration: duration,
                left: 0,
                right: 0,
                bottom: showOverlay ? 0 : -120,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 260),
                  opacity: showOverlay ? 1 : 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies
                          .map(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.workSans(
                                  color: Colors.blue[200],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),

              // (optional) small hint on mobile when first tap reveals overlay
              if (_isTouchDevice && showOverlay)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Tap again to open',
                      style: GoogleFonts.workSans(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Center(
      child: Icon(Icons.work_outline, size: 48, color: Colors.grey[700]),
    );
  }
}
