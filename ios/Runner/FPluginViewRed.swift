//
//  FPluginViewRed.swift
//  Runner
//
//  Created by Emma Sun on 2020/6/18.
//

import UIKit
import MapKit

class FPluginViewRed: UIView {
    
    static let registerId : String = "FPluginViewRed_Plugin"
    
    lazy var mapView : MKMapView = {
        let v = MKMapView(frame: .zero)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        addSubview(mapView)
        mapView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FPluginViewRedWrapper : NSObject,FlutterPlatformView {
    //自定义arguments
    var arguments : Any? = nil
    var viewId : Int64? = nil
    var frame : CGRect = .zero
    
    init(arguments:Any?,viewId:Int64?,frame:CGRect) {
        self.arguments = arguments
        self.viewId = viewId
        self.frame = frame
    }
    
    func view() -> UIView {
        let resultView = FPluginViewRed.init(frame: self.frame)
        if let tag = viewId { resultView.tag = Int(tag)} //Int64 -> Int
        return resultView
    }
}


//需要将工厂注册一下
class FPluginViewRedFactory : NSObject,FlutterPlatformViewFactory {
    static let registerId : String = "FPluginViewRedFactory_registerId"
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FPluginViewRedWrapper.init(arguments: args, viewId: viewId, frame: frame)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

