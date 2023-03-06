import '../environments.dart';
import '../hosts.dart';
import 'client_interceptor_interface.dart';

abstract class IClient {
  late Environment environment;

  late String environmentName;

  IClientInterceptor? interceptor;

  void setHostToken(String token, Host host);

  void setEnvironment(Environment environment);

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  });

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  });

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  });

  Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  });

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
  });

  Future downloadFile(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Host host = Host.undefined,
    void Function(int, int)? onReceiveProgress,
  });
}
