class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? projectUrl;
  final List<String>? features;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.projectUrl,
    this.features,
  });

  // Factory method to create a Project from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      imageUrl: json['imageUrl'] as String?,
      projectUrl: json['projectUrl'] as String?,
      features: json['features'] != null 
          ? List<String>.from(json['features'] as List) 
          : null,
    );
  }

  // Convert Project to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'technologies': technologies,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (projectUrl != null) 'projectUrl': projectUrl,
      if (features != null) 'features': features,
    };
  }

  // Create a copy of the project with some fields updated
  Project copyWith({
    String? title,
    String? description,
    List<String>? technologies,
    String? imageUrl,
    String? projectUrl,
    List<String>? features,
  }) {
    return Project(
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      imageUrl: imageUrl ?? this.imageUrl,
      projectUrl: projectUrl ?? this.projectUrl,
      features: features ?? this.features,
    );
  }

  @override
  String toString() => 'Project(title: $title, technologies: $technologies)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Project &&
      other.title == title &&
      other.description == description &&
      other.technologies.length == technologies.length &&
      other.technologies.every((tech) => technologies.contains(tech));
  }

  @override
  int get hashCode => Object.hash(title, description, technologies);
}
