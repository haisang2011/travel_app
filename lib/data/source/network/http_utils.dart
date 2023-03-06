import 'dart:io';
import 'package:travel_app/constants/api.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/network/api_result_handler.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'package:dio/dio.dart';

enum RequestMethod {
  get('GET'),
  post('POST');

  final String name;

  const RequestMethod(this.name);
}

class HttpUtils {
  late Dio dio;

  HttpUtils() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: apiUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: apiConnectionTimeout),
      receiveTimeout: const Duration(seconds: apiConnectionTimeout),
    );
    dio = Dio(baseOptions);
    printTest('HttpUtils: initialized dio');
  }

  String _applyPathVariables(
      String endPoint, Map<String, dynamic> pathVariables) {
    String result = endPoint;
    for (var entry in pathVariables.entries) {
      final replacePattern = '{${entry.key}}';
      result = result.replaceAll(replacePattern, entry.value.toString());
    }
    return result;
  }

  String _prepareForRequest(
      String endPoint, Map<String, dynamic>? pathVariables, String? token) {
    final finalToken =
        token ?? getIt<LocalStorage>().getString(key: CacheKey.apiToken);
    final finalEndPoint = pathVariables != null
        ? _applyPathVariables(endPoint, pathVariables)
        : endPoint;

    // Prepare headers
    dio.options.headers = {
      "Content-Type": "application/json",
      if (finalToken != null) "authorization": finalToken,
    };

    return finalEndPoint;
  }

  void _logDebug({
    required RequestMethod method,
    required String endPoint,
    required Response<dynamic> response,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    printResponse('${method.name}: ${response.statusCode.toString()}');
    printResponse('base: ${dio.options.baseUrl}');
    printResponse('url: $endPoint');
    printResponse('header: ${dio.options.headers}');
    if (queryParameters != null) {
      printResponse('queryParameters: $queryParameters');
    }
    if (data != null) {
      printResponse('body: $data');
    }
    printResponse('response: $response');
  }

  Future<ApiResults> _sendRequest({
    required String endPoint,
    required RequestMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? pathVariables,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool formData = true,
  }) async {
    try {
      final finalEndPoint = _prepareForRequest(endPoint, pathVariables, token);
      final Response<dynamic> response;
      switch (method) {
        case RequestMethod.get:
          response =
              await dio.get(finalEndPoint, queryParameters: queryParameters);
          break;
        case RequestMethod.post:
          response = await dio.post(
            finalEndPoint,
            data: formData ? FormData.fromMap(data ?? {}) : data,
            queryParameters: queryParameters,
          );
          break;
      }
      _logDebug(
        endPoint: finalEndPoint,
        method: method,
        response: response,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure('Cannot create connection');
    } on FormatException {
      return ApiFailure('Request data is invalid');
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.badResponse:
          return ApiFailure(e.message ?? 'Bad response');
        case DioErrorType.connectionTimeout:
          return ApiFailure('Connection timeout');
        case DioErrorType.receiveTimeout:
          return ApiFailure('Receive response timeout');
        default:
          return ApiFailure('Something was wrong, please try again');
      }
    } catch (e) {
      return ApiFailure('Something was wrong, please try again');
    }
  }

  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? pathVariables,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) {
    return _sendRequest(
      method: RequestMethod.get,
      endPoint: endPoint,
      pathVariables: pathVariables,
      queryParameters: queryParameters,
      token: token,
    );
  }

  Future<ApiResults> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? pathVariables,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
    String? token,
  }) {
    return _sendRequest(
      method: RequestMethod.post,
      endPoint: endPoint,
      data: data,
      pathVariables: pathVariables,
      queryParameters: queryParameters,
      token: token,
      formData: formData,
    );
  }
}
