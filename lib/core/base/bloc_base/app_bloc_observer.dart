import 'package:flutter_bloc/flutter_bloc.dart';
import '../logger/app_logger_impl.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    Log.d('$event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Log.d('$stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
