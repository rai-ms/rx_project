import 'package:dio/dio.dart'
    show FormData, ProgressCallback, Options, CancelToken, ResponseType;
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/base_client/base_micro_service.dart'
    show BaseMicro;
import 'package:rx_project/core/services/api_service/api_service.dart'
    show ApiService;
import 'package:rx_project/core/utils/app_enum.dart' show RequestType;
import 'package:rx_project/core/utils/app_type_def.dart' show DioResponse;

@lazySingleton
class SmallApiDispatcher with BaseMicro {
  DioResponse call({
    required RequestType type,
    required String endPoint,
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? body,
    FormData? formData,
    List<int>? binaryData,
    String? savePath,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.fetch(
          Options(
            headers: options?.headers ?? {},
            method: type.name.toUpperCase(),
            responseType:
                type == RequestType.download
                    ? ResponseType.stream
                    : ResponseType.json,
          ).compose(
            ApiService.service.dio.options,
            endPoint,
            queryParameters: queryParam,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            data:
                type == RequestType.formData
                    ? formData
                    : type == RequestType.uploadStream
                    ? binaryData
                    : body,
            cancelToken: cancelToken,
          ),
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}
