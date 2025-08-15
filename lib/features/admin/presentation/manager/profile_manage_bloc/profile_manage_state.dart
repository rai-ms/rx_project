part of 'profile_manage_bloc.dart';

class ProfileManageState extends BlocEventState{

  const ProfileManageState({super.data, super.error, super.event, super.state, super.statusCode});

  @override
  ProfileManageState clear() => ProfileManageState();

  @override
  ProfileManageState copyWith({
    Object? data,
    String? error,
    BlocEvent? event,
    BlocState? state,
    int? statusCode,
  }) {
    return ProfileManageState(
      data: data ?? this.data,
      error: error ?? this.error,
      event: event ?? this.event,
      state: state ?? this.state,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}