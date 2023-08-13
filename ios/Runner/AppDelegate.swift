import UIKit
import Flutter
import GoogleMaps
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCIiz_JtpZCDCgBUQeh_lgVILNEH88zUY4")
    WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
