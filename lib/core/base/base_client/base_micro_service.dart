import 'package:rx_project/core/handler/api_request_handler.dart'
    show ApiHandler;

mixin BaseMicro {
  final ApiHandler apiHandler = const ApiHandler();
}
