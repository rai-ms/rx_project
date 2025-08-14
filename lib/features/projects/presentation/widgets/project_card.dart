import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/project_model.dart';

class ProjectCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap ?? () {
          if (project.projectUrl != null) {
            // You can add URL launcher logic here if needed
          }
        },
        child: Container(
          width: width,
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image
              if (project.imageUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(
                    project.imageUrl!,
                    width: double.infinity,
                    height: height! * 0.6,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(),
                  ),
                )
              else
                Container(
                  height: height! * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                  ),
                  child: _buildPlaceholderIcon(),
                ),
              
              // Project Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        project.title,
                        style: GoogleFonts.workSans(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Description
                      Text(
                        project.description,
                        style: GoogleFonts.workSans(
                          color: textColor!.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Technologies
                      if (project.technologies.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: project.technologies.map((tech) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.workSans(
                                color: Colors.blue[200],
                                fontSize: 12,
                              ),
                            ),
                          )).toList(),
                        ),
                    ],
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
      child: Icon(
        Icons.work_outline,
        size: 48,
        color: Colors.grey[700],
      ),
    );
  }
}
