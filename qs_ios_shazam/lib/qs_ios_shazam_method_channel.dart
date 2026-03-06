import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qs_ios_shazam_platform_interface.dart';

/// An implementation of [QsIosShazamPlatform] that uses method channels.
class MethodChannelQsIosShazam extends QsIosShazamPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qs_ios_shazam');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
