//
//  XCAMapLocationController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/10/29.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit
import MapKit

/// 出行方式
enum RouteType {
    case driving
    case bus
    case walking
    
    var title: String {
        switch self {
        case .driving: return "驾车"
        case .bus: return "公交"
        case .walking: return "步行"
        }
    }
}

class XCAMapLocationController: UIViewController {

//    private lazy var mapView: MAMapView = {
//       let mapView = MAMapView(frame: view.bounds)
//        mapView.delegate = self
//        mapView.showsUserLocation = true
//        mapView.setZoomLevel(15.0, animated: true)
//        return mapView
//    }()
    
    private var search = AMapSearchAPI()
    
//    private var annotationView: MAAnnotationView!
    
    /// 城市、地址
    private var area: (city: String, address: String)!
    
    /// 起始经纬度
    private var coordinate: (origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)!
    /// 出行方式
    private var routeType = RouteType.driving
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "定位"
//        search?.delegate = self
        searchPOI(keyword: area?.address)
    }
}

extension XCAMapLocationController {
    /// 关键词搜索
    private func searchPOI(keyword: String?) {
        if let keyword = keyword {
            let request = AMapPOIKeywordsSearchRequest()
            request.keywords = keyword
            request.requireExtension = true
            request.city = area.city
            search?.aMapPOIKeywordsSearch(request)
        }
    }
    
    /// 路线查询
    private func searchRoutePlanning(type: RouteType) {
        switch type {
        case .driving:
            let driving = AMapDrivingRouteSearchRequest()
            driving.requireExtension = true
            driving.origin = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.origin.latitude), longitude: CGFloat(coordinate.origin.longitude))
            driving.destination = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.destination.latitude), longitude: CGFloat(coordinate.destination.longitude))
            search?.aMapDrivingRouteSearch(driving)
        case .bus:
            let bus = AMapTransitRouteSearchRequest()
            bus.requireExtension = true
            bus.city = area.city
            bus.origin = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.origin.latitude), longitude: CGFloat(coordinate.origin.longitude))
            bus.destination = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.destination.latitude), longitude: CGFloat(coordinate.destination.longitude))
            search?.aMapTransitRouteSearch(bus)
        case .walking:
            let walking = AMapWalkingRouteSearchRequest()
            walking.origin = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.origin.latitude), longitude: CGFloat(coordinate.origin.longitude))
            walking.destination = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.destination.latitude), longitude: CGFloat(coordinate.destination.longitude))
            search?.aMapWalkingRouteSearch(walking)
        }
    }
}

//extension XCAMapLocationController: MAMapViewDelegate {
//    /// 标注view的accessory view被点击时，触发该回调
//    func mapView(_ mapView: MAMapView!, annotationView view: MAAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        print("name: \(String(describing: view.annotation.title))")
//    }
//
//    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
//        // 目的地
//        if annotation.isKind(of: MAPointAnnotation.self) {
//            let indentifier = "pointReuseIndetifier"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: indentifier)
//            if let _ = annotationView {
//
//            } else {
//                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: indentifier)
//            }
//            annotationView?.canShowCallout = true
//            annotationView?.isDraggable = false
//            return annotationView
//        }
//
//        // 自己
//        if annotation.isKind(of: MAUserLocation.self) {
//            let indentifier = "userLoactionStyleReuseIndetifier"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: indentifier)
//            if let _ = annotationView {
//
//            } else {
//                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: indentifier)
//            }
//            annotationView?.image = R.image.chatup_lock()
//
//            return annotationView
//        }
//
//        return nil
//    }
//
//    /// 设备方向改变，刷新数据
//    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
//        if !updatingLocation {
//            UIView.animate(withDuration: 0.1) {
//                let degree = userLocation.heading.trueHeading - Double(mapView.rotationDegree)
//                let radin = (degree * Double.pi) / 180.0
//                self.annotationView.transform = CGAffineTransform(rotationAngle: CGFloat(radin))
//            }
//        }
//        coordinate.origin = userLocation.coordinate
//    }
//}

//extension XCAMapLocationController: AMapSearchDelegate {
//    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
//        print("定位自己的位置失败")
//    }
//
//    /// 获取查找的位置信息
//    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
//        mapView.removeAnnotations(mapView.annotations)
//        if response.count == 0 {
//            return
//        }
//
//        if let aPOI = response.pois.first {
//            var annos = [MAPointAnnotation]()
//            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(aPOI.location.latitude), longitude: CLLocationDegrees(aPOI.location.longitude))
//            let anno = MAPointAnnotation()
//            anno.coordinate = coordinate
//            anno.title = aPOI.name
//            anno.subtitle = aPOI.address
//            annos.append(anno)
//
//            mapView.addAnnotations(annos)
//            mapView.selectAnnotation(annos.first, animated: true)
//
//            self.coordinate.destination = coordinate
//            let routeTypes: [RouteType] = [.driving, .bus, .walking]
//            for routeType in routeTypes {
//                searchRoutePlanning(type: routeType)
//            }
//        }
//    }
//
//    /// 获取规划路径
//    func onRouteSearchDone(_ request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
//        // 距离
//        var distance = 0
//        // 时间
//        var duration = 0
//
//        switch routeType {
//        case .driving, .walking:
//            if let path = response.route.paths.first {
//                distance = path.distance
//                duration = path.duration
//            }
//        case .bus:
//            if let transit = response.route.transits.first {
//                distance = transit.distance
//                duration = transit.duration
//            }
//        }
//
//        switch routeType {
//        case .driving:
//            print(distanceString(distance))
//        case .bus:
//            print(distanceString(distance))
//        case .walking:
//            print(durationString(duration))
//        }
//    }
//
//    private func distanceString(_ distance: Int) -> String {
//        return distance > 1000 ? String(format: "%.1fkm", Float(distance) / 1000.0) : "\(distance)m"
//    }
//
//    private func durationString(_ duration: Int) -> String {
//        let h = duration / 3600
//        let m = (duration % 3600) / 60
//        let s = (duration % 3600) % 60
//        let hString = h > 0 ? String(format: "%d小时", h) : ""
//        let mString = m > 0 ? String(format: "%d分钟", m) : ""
//        let sString = s > 0 ? String(format: "%d秒", s) : ""
//        return hString + mString + sString
//    }
//
//}

extension XCAMapLocationController: AMapLocationManagerDelegate {
    
}


extension XCAMapLocationController {
    /// 跳转到地图app
    @objc private func openAMapApp() {
        let alertController = UIAlertController(title: "选择地图", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "苹果地图", style: .default, handler: { (actoin) in
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: self.coordinate.destination))
            toLocation.name = self.area.address
            MKMapItem.openMaps(with: [currentLocation, toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: NSNumber(booleanLiteral: true)])
        }))
        
        if UIApplication.shared.canOpenURL(URL(string: "iosamap://path")!) {
            alertController.addAction(UIAlertAction(title: "高德地图", style: .default, handler: { (action) in
                let url = "iosamap://path?sourceApplication=applicationName" + "&sid=BGVIS1" + "&name=" + "我的位置" + "&did=BGVIS2" + "&dname=" + self.area.address + "&dev=0" + "&t=0"
                UIApplication.shared.open(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, options: [:], completionHandler: nil)
            }))
            
            // iosamap://path?sourceApplication=applicationName&sid=BGVIS1&name=我的位置&did=BGVIS2&dname=洗手间&dev=0&t=0
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "baidumap://map/maker")!) {
            alertController.addAction(UIAlertAction(title: "百度地图", style: .default, handler: { (action) in
                let url = "baidumap://map/direction?origin=" + "我的位置" + "&destination=" + self.area.address + "&mode=driving" + "&region=" + self.area.city
                UIApplication.shared.open(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, options: [:], completionHandler: nil)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
