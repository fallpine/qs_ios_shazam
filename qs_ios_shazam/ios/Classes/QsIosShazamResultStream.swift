import Flutter
import UIKit

class QsIosShazamResultStream {
    // MARK: - Func

    /// 获取通道
    static func register(messenger: FlutterBinaryMessenger?) {
        guard let messenger = messenger else { return }

        let channel = FlutterEventChannel(name: "qs_ios_shazam/result", binaryMessenger: messenger)

        let streamHandler = QsIosShazamResultStreamHandler()
        channel.setStreamHandler(streamHandler)
    }

    // MARK: - Property

    static var resultStream: FlutterEventSink?
}

class QsIosShazamResultStreamHandler: FlutterViewController, FlutterStreamHandler {
    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        QsIosShazamResultStream.resultStream = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        QsIosShazamResultStream.resultStream = nil
        return nil
    }
}
