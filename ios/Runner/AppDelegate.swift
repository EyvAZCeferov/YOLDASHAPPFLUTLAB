import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging
import flutter_local_notifications


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDKVPAVqEWuZSh0w1sOKRmr-ykc5xkHE0g") 
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ application: UIApplication,
  didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    print("Token: $deviceToken")
    super.application(application,
    didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
}
