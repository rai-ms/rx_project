import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/services/api_service/api_service.dart';
import 'package:rx_project/core/utils/app_type_def.dart';
import 'base_micro_service.dart';

@singleton
class GetApiMicro with BaseMicro {
  Future<Response> call({
    Map<String, dynamic>? queryParam,
    required String endPoint,
    Map<String, dynamic>? body,
    ProgressCallback? onReceiveProgress,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return await apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.get(
          endPoint,
          queryParameters: queryParam,
          onReceiveProgress: onReceiveProgress,
          data: body,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class PostApiMicro with BaseMicro {
  Future<Response> call({
    Map<String, dynamic>? queryParam,
    required String endPoint,
    Map<String, dynamic>? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.post(
          endPoint,
          queryParameters: queryParam,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          data: body,
          options: options,
          cancelToken: CancelToken(),
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class PatchApiMicro with BaseMicro {
  Future<Response> call({
    Map<String, dynamic>? queryParam,
    required String endPoint,
    Options? options,
    Map<String, dynamic>? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.patch(
          endPoint,
          queryParameters: queryParam,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          data: body,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class PutApiMicro with BaseMicro {
  Future<Response> call({
    Map<String, dynamic>? queryParam,
    required String endPoint,
    Options? options,
    Map<String, dynamic>? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.put(
          endPoint,
          queryParameters: queryParam,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          data: body,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class DeleteApiMicro with BaseMicro {
  Future<Response> call({
    Map<String, dynamic>? queryParam,
    required String endPoint,
    Options? options,
    Map<String, dynamic>? body,
    Function? refreshTokenCallBack,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.delete(
          endPoint,
          queryParameters: queryParam,
          data: body,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class DownloadApiMicro with BaseMicro {
  Future<Response> call({
    required String url,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.download(
          url,
          savePath,
          onReceiveProgress: onReceiveProgress,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class StreamApiMicro with BaseMicro {
  Future<Response> call({
    required String url,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.get(
          url,
          options: options ?? Options(responseType: ResponseType.stream),
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class BytesApiMicro with BaseMicro {
  DioResponse<List<int>> call({
    required String url,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return await ApiService.service.dio.get<List<int>>(
      url,
      options: options ?? Options(responseType: ResponseType.bytes),
    );
  }
}

@singleton
class UploadApiMicro with BaseMicro {
  Future<Response> call({
    required String endPoint,
    required FormData formData,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    return apiHandler.dioHandler(
      apiCall: () async {
        return await ApiService.service.dio.post(
          endPoint,
          data: formData,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}

@singleton
class UploadStreamApiMicro with BaseMicro {
  Future<Response> postBinaryData({
    required String url,
    required List<int> data,
    ProgressCallback? onSendProgress,
    Function? refreshTokenCallBack,
    Options? options,
  }) async {
    final stream = Stream.fromIterable(
      data.map((e) => [e]),
    ); // Creates a Stream<List<int>>.
    final contentLength = data.length;
    return apiHandler.dioHandler(
      apiCall: () async {
        if (options != null) {
          // Adding Content length if already added header
          options.headers?.addAll({
            Headers.contentLengthHeader:
                contentLength, // Set the content-length.
          });
        }
        return await ApiService.service.dio.post(
          url,
          data: stream,
          options:
              options ??
              Options(
                headers: {
                  Headers.contentLengthHeader:
                      contentLength, // Set the content-length.
                },
              ),
          onSendProgress: onSendProgress,
        );
      },
      refreshTokenCallBack: refreshTokenCallBack,
    );
  }
}
