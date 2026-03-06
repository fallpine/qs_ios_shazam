//
//  ShazamTool.swift
//  Compress
//
//  Created by ht on 2025/7/7.
//

import AVFoundation
import ShazamKit

class ShazamTool: NSObject {
  // MARK: - System

  override init() {
    super.init()
    session.delegate = self
  }

  // MARK: - Func

  func startListening() {
    if audioEngine.isRunning {
      return
    }

    do {
      try audioSession.setCategory(
        .playAndRecord, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
      try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
      let inputNode = audioEngine.inputNode
      let recordingFormat = inputNode.outputFormat(forBus: 0)

      inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
        [weak self] buffer, _ in
        self?.session.matchStreamingBuffer(buffer, at: nil)
      }

      audioEngine.prepare()
      try audioEngine.start()
      print("🎧 开始监听音乐")
    } catch {
      print("⚠️ 音频启动失败: \(error)")
    }
  }

  func stopListening() {
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    print("🛑 停止监听")
  }

  // MARK: - Property

  private let session = SHSession()
  private let audioEngine = AVAudioEngine()
  private let audioSession = AVAudioSession.sharedInstance()
}

extension ShazamTool: SHSessionDelegate {
  func session(_: SHSession, didFind match: SHMatch) {
    var mediaItems: [[String: Any]] = []
    for rawItem in match.mediaItems {
      var item: [String: Any] = [:]
      item["shazamID"] = rawItem.shazamID
      item["title"] = rawItem.title
      item["subtitle"] = rawItem.subtitle
      item["artist"] = rawItem.artist
      item["genres"] = rawItem.genres
      item["appleMusicID"] = rawItem.appleMusicID
      if let appleUrl = rawItem.appleMusicURL {
        item["appleMusicURL"] = appleUrl.absoluteString
      }
      if let webUrl = rawItem.webURL {
        item["webURL"] = webUrl.absoluteString
      }
      if let artworkUrl = rawItem.artworkURL {
        item["artworkURL"] = artworkUrl.absoluteString
      }
      if let videoUrl = rawItem.videoURL {
        item["videoURL"] = videoUrl.absoluteString
      }
      item["explicitContent"] = rawItem.explicitContent
      item["isrc"] = rawItem.isrc

      if let albumName = rawItem[SHMediaItemProperty(rawValue: "sh_albumName")] as? String {
        item["album"] = albumName
      }

      if let releaseDate = rawItem[SHMediaItemProperty(rawValue: "sh_releaseDate")] as? Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        item["releaseDate"] = formatter.string(from: releaseDate)
      }

      mediaItems.append(item)
    }
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: mediaItems)
      let jsonString = String(data: jsonData, encoding: .utf8)
      QsIosShazamResultStream.resultStream?(jsonString)
    } catch {
      QsIosShazamResultStream.resultStream?(nil)
    }
  }

  func session(_: SHSession, didNotFindMatchFor _: SHSignature, error: Error?) {
    QsIosShazamResultStream.resultStream?(nil)
    print("❌ 未识别出任何音乐", error ?? "")
  }
}
