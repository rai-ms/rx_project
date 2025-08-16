

class HomeProjectModel {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? status;

  HomeProjectModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.status,
  });

  factory HomeProjectModel.fromJson(Map<String, dynamic> json) {
    return HomeProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
    };
  }
}