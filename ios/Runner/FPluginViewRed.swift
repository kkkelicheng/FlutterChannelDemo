//
//  FPluginViewRed.swift
//  Runner
//
//  Created by Emma Sun on 2020/6/18.
//

import UIKit
import MapKit
import CoreLocation

class FPluginViewRed: UIView,MKMapViewDelegate , CLLocationManagerDelegate{
    
    static let registerId : String = "FPluginViewRed_Plugin"
    var isFirstLoad = true
    var clManager = CLLocationManager.init()
    var geoDecoder : CLGeocoder =  CLGeocoder.init()
    
    lazy var mapView : MKMapView = {
        let v = MKMapView(frame: .zero)
        v.showsUserLocation = true
        v.userTrackingMode = .follow
        v.delegate = self
        return v
    }()

    override init(frame: CGRect) {
        print("FPluginViewRed init")
        super.init(frame: frame)
        self.backgroundColor = .red
        addSubview(mapView)
        mapView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        clManager.delegate = self
        clManager.startUpdatingLocation()
        let status = CLLocationManager.authorizationStatus().rawValue
        print("authorizationStatus \(status)")
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if isFirstLoad {
            isFirstLoad = false
            mapView.setRegion(MKCoordinateRegion.init(center: userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("didFailToLocateUserWithError : \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError : \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
    }
    
    deinit {
        print("FPluginViewRed deinit")
    }
    
    func didChangeRegionAndGeoCode(col:CLLocationCoordinate2D){
        let location = CLLocation.init(latitude: col.latitude, longitude: col.longitude)
        self.geoDecoder.reverseGeocodeLocation(location) { (places:[CLPlacemark]?, error:Error?) in
            if let places = places , let lasetPlace = places.last{
                let addressDesc = (lasetPlace.administrativeArea ?? "") + (lasetPlace.subAdministrativeArea ?? "")
            }
        }
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

