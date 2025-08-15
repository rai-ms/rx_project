import 'package:flutter/material.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/utils/app_type_def.dart' show FVoid;
import '../../base/logger/app_logger_impl.dart';

class AppDialogService extends BaseService<void, void> {
  static AppDialogService service = AppDialogService();

  @override
  void init({void param}) {
    log.d("Route Dialog Service Initialized");
  }

  FVoid showAppDialog(
    BuildContext context,
    Widget widget, [
    Function? afterPop,
  ]) async {
    showDialog(context: context, builder: (context) => widget);
    if (afterPop != null) await afterPop();
  }
}
