import 'package:rx_project/core/base/logger/app_logger_impl.dart';

enum LogMode { debug, live }

enum AppTheme {
  darkBlue("darkBlue"),
  lightRed("lightRed"),
  system("system"),
  dark("dark"),
  light("light");

  final String value;

  const AppTheme(this.value);

  static AppTheme getTheme(String? theme) {
    if (theme == null || theme.isEmpty) return AppTheme.system;
    try {
      return AppTheme.values.firstWhere((element) => element.value == theme);
    } catch (e) {
      return AppTheme.system;
    }
  }

  String getThemeVal() {
    return value;
  }

  @override
  String toString() {
    return value;
  }
}

enum ModelType { list, grid }

enum ImageType { memory, asset, link, svg, file, lottie }

enum RequestResource { camera, storage, microphone }

enum RequestType {
  get("get"),
  post("post"),
  put("put"),
  patch("patch"),
  delete("delete"),
  formData("formData"),
  download("download"),
  stream("stream"),
  bytes("bytes"),
  uploadStream("uploadStream");

  final String value;

  const RequestType(this.value);

  static RequestType fromString(String val) {
    return RequestType.values.firstWhere((test) => test.value == val);
  }

  @override
  String toString() {
    return value;
  }
}

enum ToastType { success, error }

enum FlavourType {
  prod('PROD'),
  uat('STAGING'),
  dev('DEV'),
  unknown(null);

  final String? _flavour;

  const FlavourType(this._flavour);

  static FlavourType fromString({String? val}) {
    if (val == null || val.isEmpty) return FlavourType.dev;
    log.d("Flavour Type $val");
    try {
      var fl = FlavourType.values.firstWhere(
        (FlavourType element) => element._flavour == val,
      );
      log.f("FlavourType is $fl");
      return fl;
    } catch (e) {
      log.e("Error while getting flavour type $e");
      return FlavourType.dev;
    }
  }

  @override
  String toString() {
    return _flavour ?? "unknown";
  }
}

enum TextInputFieldType {
  email,
  password,
  name,
  otp,
  none;

  bool get isEmail => this == email;

  bool get isPhone => this == password;

  bool get isName => this == name;

  bool get isOtp => this == otp;

  bool get isNone => this == none;

  String? get errorMessage => switch (this) {
    TextInputFieldType.email => "Invalid email format",
    TextInputFieldType.password => "Invalid password format",
    TextInputFieldType.name => "",
    TextInputFieldType.otp => "",
    TextInputFieldType.none => null,
  };
}

enum LoginType {
  email,
  phone;

  bool get isEmail => this == LoginType.email;
  bool get isPhone => this == LoginType.phone;
}

enum AppLanguage {
  english("en", "English"),
  hindi("hi", "हिन्दी"),
  bhojpuri("es", "भोजपुरी"),
  urdu("ur", "اردو");

  final String code;
  final String language;

  const AppLanguage(this.code, this.language);

  /// Converts a string to an AppLanguage enum value.
  /// Returns [AppLanguage.english] if the string is null, empty, or does not match any defined language.
  factory AppLanguage.fromString(String? languageCode) {
    if (languageCode == null || languageCode.isEmpty) {
      return AppLanguage.english;
    }
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == languageCode,
      orElse: () => AppLanguage.english,
    );
  }
}

enum ArrowDirection {
  right,
  left,
  top,
  down;

  bool get isRight => this == ArrowDirection.right;
  bool get isLeft => this == ArrowDirection.left;
  bool get isTop => this == ArrowDirection.top;
  bool get isDown => this == ArrowDirection.down;

  bool get isSH => this == ArrowDirection.right || this == ArrowDirection.left;
  bool get isSW => this == ArrowDirection.top || this == ArrowDirection.down;
}
