//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import desktop_window
import screen_retriever_macos
import shared_preferences_foundation
import video_player_avfoundation
import webview_flutter_wkwebview
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DesktopWindowPlugin.register(with: registry.registrar(forPlugin: "DesktopWindowPlugin"))
  ScreenRetrieverMacosPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverMacosPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  FVPVideoPlayerPlugin.register(with: registry.registrar(forPlugin: "FVPVideoPlayerPlugin"))
  FLTWebViewFlutterPlugin.register(with: registry.registrar(forPlugin: "FLTWebViewFlutterPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
