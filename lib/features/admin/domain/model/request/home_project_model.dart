

import '../../../../../core/base/logger/app_logger_impl.dart';

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
    log.d("HomeProjectModel fromJson: $json");
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

  // Write copyWith
  HomeProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? status,
  }) {
    return HomeProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
    );
  }


}