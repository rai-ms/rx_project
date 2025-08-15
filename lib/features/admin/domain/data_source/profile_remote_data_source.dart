

abstract class ProfileRemoteDataSource {
  Future<String> uploadProfilePicture(String localFilePath, String userId);
  Future<String> getProfilePictureUrl(String userId);

  const ProfileRemoteDataSource();
}
