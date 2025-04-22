import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';

class ApiClient {
  static final ApiClient instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() {
    return instance;
  }

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    // Add Pretty Dio Logger
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive Timeout";
      case DioExceptionType.sendTimeout:
        return "Send Timeout";
      case DioExceptionType.badResponse:
        return "Server Error: ${error.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request Cancelled";
      case DioExceptionType.connectionError:
        return "Connection Error";
      case DioExceptionType.unknown:
      default:
        return "Something went wrong";
    }
  }
}
