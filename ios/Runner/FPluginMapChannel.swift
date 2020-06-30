//
//  FPluginMapChannel.swift
//  Runner
//
//  Created by Emma Sun on 2020/6/29.
//

import UIKit
import Flutter

//对通信通道简单的封装
class FPluginMapChannel: NSObject {
    static let share : FPluginMapChannel = FPluginMapChannel()
    var methodChannel : FlutterMethodChannel?
    private override init(){}
    
    func initChannel(_ messager : FlutterBinaryMessenger){
        if methodChannel == nil {
            methodChannel = FlutterMethodChannel.init(name: "ios.flutter.plugin.map", binaryMessenger: messager);
        }
    }
    
    private func sendMessage(method:String,arguments:[String:Any]){
        guard let methodChannel = methodChannel else {
            return
        }
        methodChannel.invokeMethod(method, arguments: arguments)
    }
    
    func sendLocationUpdate(locationDesc:String){
        self.sendMessage(method: "locationDescUpdate", arguments: ["locationDesc":locationDesc])
    }
    
    
}
