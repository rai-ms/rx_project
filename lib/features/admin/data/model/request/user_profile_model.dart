

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
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'id': id,
    };
  }

  UserProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? profilePictureUrl,
    String? bio,
    String? role,
    String? createdAt,
    String? updatedAt,
    String? id,
  }) {
    return UserProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      bio: bio ?? this.bio,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }


  UserProfileModel createdNew(){
    return copyWith(
      createdAt: DateTime.now().toUtc().toIso8601String(),
      updatedAt: DateTime.now().toUtc().toIso8601String(),
      id: DateTime(2002,07,07).millisecondsSinceEpoch.toString(), // Temporary ID for new profile
    );
  }

}