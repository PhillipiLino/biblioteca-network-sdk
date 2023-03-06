// import 'package:biblioteca_network_sdk/clients.dart';
// import 'package:biblioteca_network_sdk/src/environments.dart';
// import 'package:biblioteca_network_sdk/src/hosts.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../dio_mock.dart';

// main() {
//   DioMock dio = DioMock();
//   final client = DioClient(dioClient: dio);

//   // test('Select Staging environment to client', () {
//   //   // Arrange
//   //   const env = Environment.staging;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'stg');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlA environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlA;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmla');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlA2 environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlA2;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmla2');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlB environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlB;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmlb');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlB2 environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlB2;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmlb2');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlC environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlC;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmlc');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlC2 environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlC2;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmlc2');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlD environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlD;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmld');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlD2 environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlD2;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmld2');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlE environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlE;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmle');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select HmlE2 environment to client', () {
//   //   // Arrange
//   //   const env = Environment.hmlE2;
//   //   const host = Host.core;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'hmle2');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   // test('Select Production environment to client', () {
//   //   // Arrange
//   //   const env = Environment.production;
//   //   const host = Host.api;

//   //   // Act
//   //   client.setEnvironment(env);

//   //   // Assert
//   //   expect(client.environment, env);
//   //   expect(client.environment.name, 'prod');
//   //   expect(client.getUrl('', host), 'https://${env.prefix}${host.url}/');
//   //   expect(client.getHeaders({}, host)?['X-API-KEY'], env.apiKey);
//   // });

//   test('Set client token', () {
//     // Given
//     const tokenApi = 'TEST_NEW_CLIENT_TOKEN';
//     const hostApi = Host.google;

//     const tokenMarketplace = 'TEST_NEW_CLIENT_TOKEN_MARKET';
//     const hostMarketplace = Host.google;

//     // When
//     client.setHostToken(tokenApi, hostApi);
//     client.setHostToken(tokenMarketplace, hostMarketplace);

//     // Then
//     expect(
//         client.getHeaders({}, hostApi)?['Authorization'], 'Bearer $tokenApi');
//     expect(client.getHeaders({}, hostMarketplace)?['Authorization'],
//         'Bearer $tokenMarketplace');
//   });

//   test('Get url with solfacil endpoint', () {
//     // Arrange
//     const url = 'url_test';
//     const env = Environment.production;
//     const host = Host.api;

//     // Act
//     client.setEnvironment(env);
//     final requestUrl = client.getUrl(url, host);

//     // Assert
//     expect(client.environment, env);
//     expect(client.environment.name, 'prod');
//     expect(requestUrl, 'https://${env.prefix}${host.url}/$url');
//   });

//   test('Get url with undefined host', () {
//     // Given
//     const url = 'url_test';
//     const env = Environment.production;
//     const host = Host.undefined;

//     // Act
//     client.setEnvironment(env);
//     final requestUrl = client.getUrl(url, host);

//     // Assert
//     expect(client.environment, env);
//     expect(client.environment.name, 'prod');
//     expect(requestUrl, url);
//   });

//   test('Get headers with solfacil endpoint', () {
//     // Arrange
//     const newHeaders = {'teste_key': 'test_value'};
//     const env = Environment.production;
//     const host = Host.api;

//     // Act
//     client.setEnvironment(env);
//     final requestHeaders = client.getHeaders(newHeaders, host);

//     // Assert
//     expect(client.environment, env);
//     expect(client.environment.name, 'prod');
//     expect(requestHeaders?['X-API-KEY'], env.apiKey);
//     expect(requestHeaders?['test_key'], newHeaders['test_key']);
//   });

//   test('Get headers with undefined host', () {
//     // Given
//     const newHeaders = {'teste_key': 'test_value'};
//     const env = Environment.production;
//     const host = Host.undefined;

//     // Act
//     client.setEnvironment(env);
//     final requestHeaders = client.getHeaders(newHeaders, host);

//     // Assert
//     expect(client.environment, env);
//     expect(client.environment.name, 'prod');
//     expect(requestHeaders?['X-API-KEY'], isNull);
//     expect(requestHeaders?['test_key'], newHeaders['test_key']);
//   });
// }
