class UserProfileModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? address;
  String? bio;
  String? role;
  String? profilePictureUrl;
  
  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.bio,
    this.role,
    this.profilePictureUrl,
  });
  
  // Add fromJson and toJson methods if needed
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      bio: json['bio'],
      role: json['role'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'bio': bio,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
