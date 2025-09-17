class ResumeDataModel {
  final String resumeUrl;
  final String? profileImageUrl;
  final bool showResumeViaLink;

  const ResumeDataModel({
    this.resumeUrl = '',
    this.profileImageUrl,
    this.showResumeViaLink = false,
  });

  factory ResumeDataModel.fromMap(Map<String, dynamic> map) {
    return ResumeDataModel(
      resumeUrl: map['resumeUrl'] as String? ?? '',
      profileImageUrl: map['profileImageUrl'] as String?,
      showResumeViaLink: map['showResumeViaLink'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'resumeUrl': resumeUrl,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'showResumeViaLink': showResumeViaLink,
    };
  }
  
  ResumeDataModel copyWith({
    String? resumeUrl,
    String? profileImageUrl,
    bool? showResumeViaLink,
  }) {
    return ResumeDataModel(
      resumeUrl: resumeUrl ?? this.resumeUrl,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      showResumeViaLink: showResumeViaLink ?? this.showResumeViaLink,
    );
  }
}
