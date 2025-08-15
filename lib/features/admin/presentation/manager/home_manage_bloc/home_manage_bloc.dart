
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/bloc_base/bloc_event.dart';
import 'package:rx_project/core/base/bloc_base/bloc_event_state.dart';

part 'home_manage_event.dart';
part 'home_manage_state.dart';

@injectable
class HomeManageBloc extends Bloc<HomeManageEvent, HomeManageState> {

  @factoryMethod
  HomeManageBloc() : super(HomeManageState()) {
    on<HomeManageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
