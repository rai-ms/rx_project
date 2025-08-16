import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/core/services/di/injector.dart';

import '../../features/admin/presentation/manager/home_manage_bloc/home_manage_bloc.dart' show HomeManageBloc;
import '../../features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart' show ProfileManageBloc;
import '../../features/admin/presentation/manager/projects_bloc/projects_bloc.dart' show ProjectsBloc;

class BlocProviders {
  static List<BlocProvider> blocProviderForMyApp = [
    BlocProvider<ProfileManageBloc>(
      create:
        ( context) => InjectorService.service.inject<ProfileManageBloc>(),
    ),
    BlocProvider<HomeManageBloc>(
      create:
        (context) => InjectorService.service.inject<HomeManageBloc>(),
    ),
    BlocProvider<ProjectsBloc>(
      create:
        (context) => InjectorService.service.inject<ProjectsBloc>(),
    ),

  ];
}
