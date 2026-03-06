import Flutter
import UIKit

public class QsIosShazamPlugin: NSObject, FlutterPlugin {
  /// Func
  public static func register(with registrar: FlutterPluginRegistrar) {
    // 注册流
    QsIosShazamResultStream.register(messenger: registrar.messenger())

    let channel = FlutterMethodChannel(name: "qs_ios_shazam", binaryMessenger: registrar.messenger())
    let instance = QsIosShazamPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startListening":
      startListening()
      result("")

    case "stopListening":
      stopListening()
      result("")
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func startListening() {
    shazamTool.startListening()
  }

  func stopListening() {
    shazamTool.stopListening()
  }

  /// Property
  private let shazamTool = ShazamTool()
}
