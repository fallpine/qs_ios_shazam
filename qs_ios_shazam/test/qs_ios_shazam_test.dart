import 'package:flutter_test/flutter_test.dart';
import 'package:qs_ios_shazam/qs_ios_shazam_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQsIosShazamPlatform with MockPlatformInterfaceMixin implements QsIosShazamPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {}
