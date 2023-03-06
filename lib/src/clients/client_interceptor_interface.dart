
import 'package:commons_tools_sdk/logger.dart';

abstract class IClientInterceptor {
  bool onDoRequest(RequestLogEvent event);
  bool onReceiveResponse(RequestLogEvent event);
  bool onReceiveError(RequestLogEvent event);
}
