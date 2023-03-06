import 'package:commons_tools_sdk/logger.dart';
import 'package:dio/dio.dart';

import '../../helpers/request_log_event_helper.dart';
import '../client_interceptor_interface.dart';

class DioClientInterceptor extends Interceptor {
  final IClientInterceptor? _interceptor;

  DioClientInterceptor(this._interceptor);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final logEvent = RequestLogEventExtension.fromDioRequest(options);
    LogManager.shared.logRequestEvent(logEvent);
    final proceed = _interceptor?.onDoRequest(logEvent) ?? true;
    if (!proceed) return;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logEvent = RequestLogEventExtension.fromDioResponse(response);
    LogManager.shared.logRequestEvent(logEvent);

    final proceed = _interceptor?.onReceiveResponse(logEvent) ?? true;
    if (!proceed) return;

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final logEvent = RequestLogEventExtension.fromDioError(err);
    final proceed = _interceptor?.onReceiveError(logEvent) ?? true;
    if (!proceed) return;

    super.onError(err, handler);
  }
}
