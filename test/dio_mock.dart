import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  @override
  Interceptors get interceptors => Interceptors();

  late BaseOptions mockOptions;

  DioMock() {
    mockOptions = BaseOptions();
  }

  @override
  BaseOptions get options => mockOptions;

  @override
  set options(BaseOptions options) {
    mockOptions = options;
  }
}
