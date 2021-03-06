import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
   var manager : CLLocationManager = CLLocationManager.init()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    
    
    self.registerBatteryPluginWithBinaryMessager(controller.binaryMessenger)
    
    FPluginMapChannel.share.initChannel(controller.binaryMessenger)
    self.registerCustomViewPlugin()
    
    manager.requestWhenInUseAuthorization()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}


//电池插件
extension AppDelegate {
    private func registerBatteryPluginWithBinaryMessager(_ messager : FlutterBinaryMessenger){
        //建立与flutter的通信
        let batteryChannel = FlutterMethodChannel.init(name: "ios.flutter.plugin.battery", binaryMessenger: messager)
        //监听通信
        batteryChannel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
            //dart 调用 platform.invokeMethod('getBatteryLevel');触发
            if ("getBatteryLevel" == call.method) {
                self.receiveBatteryLevel(result: result);
            } else {
                result(FlutterMethodNotImplemented);
            }
        }
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current;
        device.isBatteryMonitoringEnabled = true;
        if (device.batteryState == UIDevice.BatteryState.unknown) {
            result(FlutterError.init(code: "UNAVAILABLE",
                                     message: "Battery info unavailable",
                                     details: nil));
        } else {
            result(Int(device.batteryLevel * 100));
        }
    }
}

//自定义视图
extension AppDelegate {
    private func registerCustomViewPlugin(){
        let registrar = self.registrar(forPlugin: FPluginViewRed.registerId)
        
       // A unique identifier for the factory, the Dart code of the Flutter app can use
       // this identifier to request creation of a `UIView` by the registered factory
        //登记员注册一个工厂，用来创建插件 Plugins expose `UIView` for embedding in Flutter apps by registering a view factory
        //所以在dart中，会使用这个工厂的Id 去生产出View
        /* Dart
         mapView = UiKitView(
                viewType: "FPluginViewRedFactory_registerId",
                creationParams: {"lat": 20.000, "long": 120.0},
                creationParamsCodec: const StandardMessageCodec(),
         );
         */
        registrar.register(
            FPluginViewRedFactory(),
            withId: FPluginViewRedFactory.registerId,
            gestureRecognizersBlockingPolicy:
            FlutterPlatformViewGestureRecognizersBlockingPolicyWaitUntilTouchesEnded)
    }
}
