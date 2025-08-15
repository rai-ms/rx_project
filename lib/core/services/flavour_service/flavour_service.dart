import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rx_project/core/base/base_service/base_service.dart';
import 'package:rx_project/core/base/flavour_base/flavour.dart';
import 'package:rx_project/core/utils/app_enum.dart';
import '../../base/logger/app_logger_impl.dart';

@protected
class FlavourService extends BaseService<Future<String?>, String> {
  FlavourService();

  static final FlavourService service = FlavourService();
  late final Flavour flavour;

  @override
  Future<String?> init({String? param}) async {
    String data = const String.fromEnvironment("FLAVOUR");
    FlavourType type = FlavourType.fromString(val: data);
    flavour = await getFlavour(type);
    log.d(
      "Flavour is ${flavour.runtimeType} and base Url is ${flavour.baseUrl}",
    );
    return data;
  }

  Future<Flavour> getFlavour(FlavourType type) async {
    return FlavourImpl();
  }
}
