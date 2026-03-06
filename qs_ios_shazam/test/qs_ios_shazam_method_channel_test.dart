import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qs_ios_shazam/qs_ios_shazam_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelQsIosShazam platform = MethodChannelQsIosShazam();
  const MethodChannel channel = MethodChannel('qs_ios_shazam');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
