//
//  FPluginBattery.swift
//  Runner
//
//  Created by Emma Sun on 2020/6/18.
//

import Foundation

//这里的类已经要继承自NSObject，因为要实现FlutterBinaryMessenger
class FPluginBattery : NSObject {
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

extension FPluginBattery : FlutterBinaryMessenger{
    func setMessageHandlerOnChannel(_ channel: String, binaryMessageHandler handler: FlutterBinaryMessageHandler? = nil) {
        
    }
    
    
    /// Sends a binary message to the Flutter side on the specified channel, expecting no reply.
    /// - Parameters:
    ///   - channel: The channel name.
    ///   - message: The message. 居然是一个二进制的
    func send(onChannel channel: String, message: Data?) {
        
    }
    
    
    /// Sends a binary message to the Flutter side on the specified channel, expecting an asynchronous reply.
    /// - Parameters:
    ///   - channel: The channel name.
    ///   - message: The message. 居然是一个二进制的
    ///   - callback: A callback for receiving a reply.
    func send(onChannel channel: String, message: Data?, binaryReply callback: FlutterBinaryReply? = nil) {
        
    }
}
