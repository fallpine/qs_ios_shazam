import 'package:flutter/services.dart';

class QsShazamResultStream {
  static const EventChannel _channel = EventChannel(
    "qs_ios_shazam/result",
  );
  static Stream<dynamic> get resultStream =>
      _channel.receiveBroadcastStream();
}
