import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qs_ios_shazam/qs_ios_shazam_result_stream.dart';
import 'package:qs_ios_shazam/qs_shazam_media_model.dart';
import 'qs_ios_shazam_platform_interface.dart';

class QsIosShazam {
  /// Func
  Future<String?> getPlatformVersion() {
    return QsIosShazamPlatform.instance.getPlatformVersion();
  }

  static Future<void> startListening({
    required Function(List<QsShazamMediaModel>?) onMatchResult,
  }) async {
    QsShazamResultStream.resultStream.listen((event) {
      if (event is String) {
        onMatchResult(stringToShazamList(event));
      } else {
        onMatchResult(null);
      }
    });

    await _channel.invokeMethod('startListening');
  }

  static Future<void> stopListening() async {
    await _channel.invokeMethod('stopListening');
  }

  /// 将JSON字符串转换为 List<QsShazamMediaModel>
  static List<QsShazamMediaModel> stringToShazamList(String jsonString) {
    try {
      // 解析JSON字符串为List
      List<dynamic> jsonList = jsonDecode(jsonString);

      // 将每个JSON对象转换为QsShazamMediaModel
      List<QsShazamMediaModel> shazamList =
          jsonList.map((json) {
            return QsShazamMediaModel.fromJson(json);
          }).toList();

      return shazamList;
    } catch (e) {
      if (kDebugMode) {
        print('JSON解析错误: $e');
      }
      return [];
    }
  }

  /// Property
  static const MethodChannel _channel = MethodChannel('qs_ios_shazam');
}
