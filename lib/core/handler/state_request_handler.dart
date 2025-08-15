import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StateRequestHandler {
  StateRequestHandler();
  Future call({
    required Future Function() apiCall,
    required Function(DioException e) dioError,
    required Function(dynamic) error,
  }) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      dioError(e);
    } catch (e) {
      error(e);
    }
    return null;
  }
}
