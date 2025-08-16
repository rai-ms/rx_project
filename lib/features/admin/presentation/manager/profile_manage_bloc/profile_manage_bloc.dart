import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/bloc_base/bloc_event.dart';
import 'package:rx_project/core/base/bloc_base/bloc_event_state.dart';
import 'package:rx_project/core/utils/app_type_def.dart';
import 'package:rx_project/features/admin/domain/use_case/user_profile_use_cases.dart';

import '../../../../../core/base/logger/app_logger_impl.dart';
import '../../../data/model/request/user_profile_model.dart' show UserProfileModel;

part 'profile_manage_event.dart';
part 'profile_manage_state.dart';

@injectable
class ProfileManageBloc extends Bloc<ProfileManageEvent, ProfileManageState> {

  final CreateUserProfileUseCase _createUserProfileUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetAllUserProfilesUseCase _getAllUserProfilesUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final DeleteUserProfileUseCase _deleteUserProfileUseCase;


  @factoryMethod
  ProfileManageBloc(
      this._createUserProfileUseCase,
      this._deleteUserProfileUseCase,
      this._getAllUserProfilesUseCase,
      this._getUserProfileUseCase,
      this._updateUserProfileUseCase
    ) : super(ProfileManageState()) {
    on<ProfileManageEvent>((event, emit) {});
    on<CreateUserEvent>(_createUserProfile);
    on<UpdateUserEvent>(_updateUserProfile);
    on<LoadUserProfileEvent>(_loadUserProfile);
  }


  FVoid _createUserProfile(
    CreateUserEvent event,
    Emitter<ProfileManageState> emit,
  ) async {
    emit(state.copyWith(state: state.loading));
    final result = await _createUserProfileUseCase(params: event.userProfile);
    log.d("CreateUserProfileUseCase result: ${result.isRight()}");
    result.fold(
      (failure) {
        // Log the value received in failure
        log.e("CreateUserProfileUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (userProfile) {
        // Log the value received in success
        log.d("CreateUserProfileUseCase success: ${userProfile.toJson()}");
        emit(state.copyWith(data: userProfile, state: state.success));
      },
    );
  }


  // Write the method for update profile
  FVoid _updateUserProfile(
    UpdateUserEvent event,
    Emitter<ProfileManageState> emit,
  ) async {
    emit(state.copyWith(state: state.loading));
    final result = await _updateUserProfileUseCase(params: event.userProfile);
    log.d("UpdateUserProfileUseCase result: ${result.isRight()}");
    result.fold(
      (failure) {
        // Log the value received in failure
        log.e("UpdateUserProfileUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (userProfile) {
        // Log the value received in success
        log.d("UpdateUserProfileUseCase success: ${userProfile.toJson()}");
        emit(state.copyWith(data: userProfile, state: state.success));
      },
    );
  }


  FVoid _loadUserProfile(
    LoadUserProfileEvent event,
    Emitter<ProfileManageState> emit,
  ) async {
    if(state.data != null && state.isSuccess) {
      log.d("User profile already exists, updating...");
      return;
    }
    emit(state.copyWith(state: state.loading));
    final result = await _getUserProfileUseCase(params: "1025980200000");
    log.d("GetUserProfileUseCase result: ${result.isRight()}");
    result.fold(
      (failure) {
        // Log the value received in failure
        log.e("GetUserProfileUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (userProfile) {
        // Log the value received in success
        log.d("GetUserProfileUseCase success: ${userProfile.toJson()}");
        emit(state.copyWith(data: userProfile, state: state.success));
      },
    );
  }
}
