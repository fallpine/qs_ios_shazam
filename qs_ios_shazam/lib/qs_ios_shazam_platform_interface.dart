import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qs_ios_shazam_method_channel.dart';

abstract class QsIosShazamPlatform extends PlatformInterface {
  /// Constructs a QsIosShazamPlatform.
  QsIosShazamPlatform() : super(token: _token);

  static final Object _token = Object();

  static QsIosShazamPlatform _instance = MethodChannelQsIosShazam();

  /// The default instance of [QsIosShazamPlatform] to use.
  ///
  /// Defaults to [MethodChannelQsIosShazam].
  static QsIosShazamPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QsIosShazamPlatform] when
  /// they register themselves.
  static set instance(QsIosShazamPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
