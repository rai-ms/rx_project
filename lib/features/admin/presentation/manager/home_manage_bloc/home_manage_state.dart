part of 'home_manage_bloc.dart';

class HomeManageState extends BlocEventState{

  const HomeManageState({super.data, super.error, super.event, super.state, super.statusCode});

  @override
  HomeManageState clear() => HomeManageState();

  @override
  HomeManageState copyWith({
    Object? data,
    String? error,
    BlocEvent? event,
    BlocState? state,
    int? statusCode,
  }) {
   return HomeManageState(
      data: data ?? this.data,
      error: error ?? this.error,
      event: event ?? this.event,
      state: state ?? this.state,
      statusCode: statusCode ?? this.statusCode,
   );
  }

}