/// Enum representing different form fields used in the application.
/// This helps in maintaining type safety and consistency across the app.
enum FormFieldType {
  firstName('First Name'),
  lastName('Last Name'),
  email('Email'),
  phoneNumber('Phone Number'),
  address('Address'),
  bio('Bio'),
  role('Role'),
  profilePictureUrl('Profile Picture URL');

  final String displayName;
  
  const FormFieldType(this.displayName);
  
  /// Returns the string representation of the field type
  String get fieldName => name;
  
  /// Returns the display name for the field
  @override
  String toString() => displayName;
  
  /// Returns the appropriate keyboard type for the field
  String? get keyboardType => switch (this) {
        email => 'email',
        phoneNumber => 'phone',
        _ => 'text',
      };
      
  /// Returns the maximum lines for the field
  int get maxLines => this == address || this == bio ? 3 : 1;
}
