part of 'profile_manage_bloc.dart';

class ProfileManageEvent extends BlocEvent {
  const ProfileManageEvent();
}


class CreateUserEvent extends ProfileManageEvent {
  final UserProfileModel userProfile;

  const CreateUserEvent({
    required this.userProfile,
  });
}
class UpdateUserEvent extends ProfileManageEvent {
  final UserProfileModel userProfile;

  const UpdateUserEvent({
    required this.userProfile,
  });
}