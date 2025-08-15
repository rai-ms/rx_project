// ignore_for_file: implementation_imports

import 'package:dio/src/dio.dart';
import 'package:dio/src/options.dart';
import 'dart:developer' as d;
import 'package:rx_project/core/base/base_client/base_client.dart';
import 'package:rx_project/core/base/base_client/base_interceptor.dart';
import 'package:rx_project/core/utils/config/app_config_impl.dart';
import 'package:network_logger/network_logger.dart' show DioNetworkLogger;
import '../../base/logger/app_logger_impl.dart';
import '../flavour_service/flavour_service.dart';
import '../../base/base_service/base_service.dart';

class ApiService extends BaseService<void, String?> with BaseClientDio {
  static const ApiService service = ApiService();

  const ApiService();

  @override
  BaseOptions get baseOptions => BaseOptions(
    baseUrl: FlavourService.service.flavour.baseUrl,
    connectTimeout: const Duration(minutes: 5),
    receiveTimeout: const Duration(minutes: 5),
  );

  @override
  Dio get dio => _dio();

  Dio _dio() {
    var dio = Dio(baseOptions);
    if (AppConfigurations().isLoggerEnable) {
      dio.interceptors.add(
        BaseInterceptor(
          logPrint: d.log,
          responseBody: false,
          responseHeader: false,
          requestBody: true,
          requestHeader: false,
          queryParameters: false,
          showProcessingTime: false,
          convertFormData: false,
        ),
      );
      if (AppConfigurations().isNetworkLoggerEnable) {
        dio.interceptors.add(DioNetworkLogger());
      }
    }
    return dio;
  }

  @override
  void init({String? param}) {
    log.d("Initializing ApiService");
  }
}
