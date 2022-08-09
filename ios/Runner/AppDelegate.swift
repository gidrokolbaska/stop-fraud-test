import UIKit
import Flutter
import SafariServices

@available(iOS 13.0.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let METHOD_CHANNEL_NAME = "com.gidrokolbaska.stopFraud/extension"
      
      let extensionChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      extensionChannel.setMethodCallHandler({
           (call:FlutterMethodCall,result: @escaping FlutterResult) -> Void in
          switch call.method {
          case "testreloadExtension":
              result(self.reloadBlocker())
          case "getExtensionStatus":
              
              Task{result(await self.getExtensionStatus())}
          default:
              result(FlutterMethodNotImplemented)
          }
          })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func reloadBlocker()-> Bool{
        print("reloading content blocker")
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: "com.gidrokolbaska.stopFraud.EasyBlocker", completionHandler: { error in
          // Handle error
            if error == nil{
                print("reloaded");
                }
            
        })
        return true
    }
    private func getExtensionStatus() async ->Bool{
        var stateValue:Bool = false

        stateValue = try! await SFContentBlockerManager.stateOfContentBlocker(withIdentifier: "com.gidrokolbaska.stopFraud.EasyBlocker").isEnabled
       
        return stateValue
       
    }
}
