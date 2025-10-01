import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
  override func application(_ app: NSApplication, open urls: [URL]) {
    for url in urls {
      if url.scheme == "com.googleusercontent.apps.843407503335-5mkhb2ufjlhnad3g5br74iq9httmllrg" {
        // Notificar o plugin do Google Sign-In sobre o callback
        if let flutterViewController = mainFlutterWindow?.contentViewController as? FlutterViewController {
          let channel = FlutterMethodChannel(name: "plugins.flutter.io/google_sign_in_macos", binaryMessenger: flutterViewController.engine.binaryMessenger)
          channel.invokeMethod("routeUpdated", arguments: ["location": url.absoluteString, "state": nil])
        }
      }
    }
  }
}
