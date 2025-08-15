abstract class ApiEndPoint {
  static const String userProfile = "/users/";
  static const String getLatestVersion = "api/v1/version/getlatestversion";
  static const String postNewVersion = "api/v1/version/add";
  static const String login = "auth/login";
  static String updateVersion(String version) => "/api/v1/version/updateVersion/$version";
}
