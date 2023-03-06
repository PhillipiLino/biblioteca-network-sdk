import 'dart:async';
import 'dart:convert';

import 'package:biblioteca_network_sdk/src/helpers/dio_error_extensions.dart';
import 'package:commons_tools_sdk/error_report.dart';
import 'package:commons_tools_sdk/logger.dart';
import 'package:dio/dio.dart';

import '../../environments.dart';
import '../../helpers/request_log_event_helper.dart';
import '../../hosts.dart';
import '../../models/request_exception.dart';
import '../client_interceptor_interface.dart';
import '../client_interface.dart';
import 'dio_client_interceptor.dart';

class DioClient implements IClient {
  late Dio _dio;

  @override
  late Environment environment;

  @override
  late String environmentName;

  @override
  IClientInterceptor? interceptor;

  final Map<Host, String> _hostsTokens = {};

  final IErrorReport? errorReport;

  DioClient({
    Dio? dioClient,
    List<LogType> typesToLog = const [],
    Environment initialEnvironment = const Environment(
      name: '',
      prefix: '',
      apiKey: '',
      type: EnvironmentType.hml,
    ),
    IClientInterceptor? interceptor,
    String? userAgent,
    String? appVersion,
    this.errorReport,
  }) {
    _dio = dioClient ?? Dio();
    final dioInterceptor = DioClientInterceptor(interceptor);

    LogManager.shared.typesToLog = typesToLog;
    _dio.interceptors.add(dioInterceptor);
    _dio.options.headers['accept-language'] = 'pt-BR';
    _dio.options.headers['user-agent'] = userAgent;
    _dio.options.headers['app-version'] = appVersion;
    _dio.options = BaseOptions(
      connectTimeout: 120000,
      receiveTimeout: 60000,
    );

    setEnvironment(initialEnvironment);
  }

  @override
  setHostToken(String token, Host host) {
    _hostsTokens[host] = token;
  }

  @override
  setEnvironment(Environment environment) {
    this.environment = environment;
    environmentName = environment.name;
  }

  @override
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;

    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    final Response response = await _dio
        .get(
          requestUrl,
          queryParameters: queryParameters,
          options: Options(headers: requestHeaders),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  @override
  Future post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;
    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    final Response response = await _dio
        .post(
          requestUrl,
          options: Options(headers: requestHeaders),
          queryParameters: queryParameters,
          data: jsonEncode(body),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  @override
  Future patch(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;
    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    final Response response = await _dio
        .patch(
          requestUrl,
          options: Options(headers: requestHeaders),
          queryParameters: queryParameters,
          data: jsonEncode(body),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  @override
  Future put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;
    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    final Response response = await _dio
        .put(
          requestUrl,
          options: Options(headers: requestHeaders),
          queryParameters: queryParameters,
          data: jsonEncode(body),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  @override
  Future delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;
    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    final Response response = await _dio
        .delete(
          requestUrl,
          options: Options(headers: requestHeaders),
          queryParameters: queryParameters,
          data: jsonEncode(body),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  @override
  Future downloadFile(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    void Function(int, int)? onReceiveProgress,
    Host host = Host.undefined,
  }) async {
    var stack = StackTrace.current;

    final requestUrl = getUrl(url, host);
    final requestHeaders = getHeaders(headers, host);

    Response response = await _dio
        .get(
          requestUrl,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: requestHeaders,
            responseType: ResponseType.bytes,
            followRedirects: false,
          ),
        )
        .catchError((error) => _onError(error, stack));

    return _parseSuccess(response);
  }

  String getUrl(String url, Host host) {
    String hostUrl = host.url;

    String requestUrl = 'https://${environment.prefix}$hostUrl/$url';
    if (host == Host.undefined) {
      requestUrl = url;
    }

    return requestUrl;
  }

  Map<String, dynamic>? getHeaders(Map<String, dynamic>? headers, Host host) {
    final hostToken = _hostsTokens[host];
    final hasToken = hostToken != null && hostToken.isNotEmpty;

    return host != Host.undefined
        ? {
            'X-API-KEY': environment.apiKey,
            if (hasToken) 'Authorization': 'Bearer $hostToken',
            ...(headers ?? {}),
          }
        : headers;
  }

  _onError(
    DioError error,
    StackTrace stackTrace,
  ) {
    final event = RequestLogEventExtension.fromDioError(error, stackTrace);
    final exception = error.toException(stackTrace);
    final newTrace = _adjustStackTrace(stackTrace);

    LogManager.shared.logRequestEvent(event);
    errorReport?.recordException(
      exception: exception,
      stack: newTrace,
      reason: exception.rawMessage ?? '',
      errorCode: exception.statusCode,
      printDebugLog: LogManager.shared.typesToLog.contains(LogType.error),
    );

    throw exception;
  }

  StackTrace _adjustStackTrace(StackTrace stack) {
    final regex = RegExp(r'^#\d{1,3}');
    List<String> splitted =
        stack.toString().replaceAll('"', '').split('\n').reversed.toList();
    List<String> newList = [];
    splitted.removeWhere((value) => value.contains('Store.executeEither'));
    splitted
        .removeWhere((value) => value.contains('<asynchronous suspension>'));

    int counter = 0;
    for (var i = 0; i < splitted.length; i++) {
      final newValue =
          splitted[i].replaceAll(regex, '').replaceAll('      ', '');
      newList.add('#$counter      $newValue');
      counter++;
    }

    newList.removeWhere((element) => element.isEmpty);
    return StackTrace.fromString(newList.join('\n'));
  }

  dynamic _parseSuccess(Response response) {
    int statusCode = response.statusCode ?? 0;

    if (199 < statusCode && statusCode < 300) return response.data;

    throw RequestException(statusCode, 'Unknown Error', null);
  }
}
