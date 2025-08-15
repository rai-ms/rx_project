import 'package:dio/dio.dart' show FormData, ProgressCallback, Options;
import 'package:injectable/injectable.dart' show LazySingleton;
import 'package:rx_project/core/base/base_client/base_api_micro.dart';
import 'package:rx_project/core/handler/app_error/app_error.dart';
import 'package:rx_project/core/services/internet_service/internet_service.dart';
import 'package:rx_project/core/utils/app_enum.dart';
import 'package:rx_project/core/utils/app_type_def.dart';

@LazySingleton()
class ApiDispatcher {
  final GetApiMicro getApi;
  final PostApiMicro postApi;
  final PutApiMicro putApi;
  final PatchApiMicro patchApi;
  final DeleteApiMicro deleteApi;
  final DownloadApiMicro downloadApi;
  final StreamApiMicro streamApi;
  final BytesApiMicro bytesApi;
  final UploadApiMicro uploadApi;
  final UploadStreamApiMicro uploadStreamApi;

  ApiDispatcher(
    this.getApi,
    this.postApi,
    this.putApi,
    this.patchApi,
    this.deleteApi,
    this.downloadApi,
    this.streamApi,
    this.bytesApi,
    this.uploadApi,
    this.uploadStreamApi,
  );

  DioResponse dispatch({
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
  }) async {
    if (!await InternetService.service.isConnected()) {
      throw NetworkNotFoundException();
    }
    switch (type) {
      case RequestType.get:
        return await getApi.call(
          endPoint: endPoint,
          queryParam: queryParam,
          body: body,
          onReceiveProgress: onReceiveProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.post:
        return await postApi.call(
          endPoint: endPoint,
          queryParam: queryParam,
          body: body,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.put:
        return await putApi.call(
          endPoint: endPoint,
          queryParam: queryParam,
          body: body,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.patch:
        return await patchApi.call(
          endPoint: endPoint,
          queryParam: queryParam,
          body: body,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.delete:
        return await deleteApi.call(
          endPoint: endPoint,
          queryParam: queryParam,
          body: body,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.download:
        if (savePath == null) {
          throw ArgumentError("savePath is required for download");
        }
        return await downloadApi.call(
          url: endPoint,
          savePath: savePath,
          onReceiveProgress: onReceiveProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.stream:
        return await streamApi.call(
          url: endPoint,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.bytes:
        return await bytesApi.call(
          url: endPoint,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.formData:
        if (formData == null) {
          throw ArgumentError("formData is required for upload");
        }
        return await uploadApi.call(
          endPoint: endPoint,
          formData: formData,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
      case RequestType.uploadStream:
        if (binaryData == null) {
          throw ArgumentError("binaryData is required for uploadStream");
        }
        return await uploadStreamApi.postBinaryData(
          url: endPoint,
          data: binaryData,
          onSendProgress: onSendProgress,
          refreshTokenCallBack: refreshTokenCallBack,
          options: options,
        );
    }
  }
}