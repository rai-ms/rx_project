

class UserProfileModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? address;
  String? profilePictureUrl;
  String? bio;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? fullName;

  UserProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.bio,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    profilePictureUrl = json['profile_picture_url'];
    bio = json['bio'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    fullName = '$firstName $lastName';
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'profile_picture_url': profilePictureUrl,
      'bio': bio,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id': id,
    };
  }

}