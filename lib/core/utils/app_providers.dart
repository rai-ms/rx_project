import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/core/services/di/injector.dart';

class BlocProviders {
  static List<BlocProvider> blocProviderForMyApp = [
    // BlocProvider<SplashBloc>(
    //   create:
    //       (BuildContext context) =>
    //           InjectorService.service.inject<SplashBloc>(),
    // ),
    // BlocProvider<LoginBloc>(
    //   create:
    //       (BuildContext context) => InjectorService.service.inject<LoginBloc>(),
    // ),

  ];
}
