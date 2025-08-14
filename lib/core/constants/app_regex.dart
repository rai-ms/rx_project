class AppRegex {
  // Email validation regex
  static final email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  
  // Phone number validation regex (supports international format)
  static final phone = RegExp(r'^\+?[\d\s-]{10,}$');
  
  // URL validation regex
  static final url = RegExp(
    r'^(https?:\/\/)?' // http:// or https://
    r'([\da-z\.-]+)\.' // domain
    r'([a-z\.]{2,6})' // top level domain
    r'([\/\w \.-]*)*\/?$' // path
  );
  
  // Password validation (at least 8 chars, 1 uppercase, 1 lowercase, 1 number)
  static final password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$'
  );
  
  // Username validation (alphanumeric with underscores and dots)
  static final username = RegExp(r'^[a-zA-Z0-9_.]+$');
}