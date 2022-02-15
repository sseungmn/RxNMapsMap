import Foundation
import NMapsMap
import RxSwift
import RxCocoa

extension Reactive where Base: NMFMapView {
    public var delegate: DelegateProxy<NMFMapView, NMFMapViewDelegate> {
        return RxNMFMapViewDelegateProxy.proxy(for: self.base)
    }
    
    // delegate.mapViewIdle(mapView: NMFMapView)
    func toNMFMapView(_ args: [Any]) throws -> NMFMapView {
        let mapView = try castOrThrow(NMFMapView.self, args[0])
        return mapView
    }
    /// 맵뷰의 이동이 멈췄을 때 호출됩니다.
    public var mapViewIdle: ControlEvent<NMFMapView> {
        let source: Observable<NMFMapView> = delegate
            .methodInvoked(#selector(NMFMapViewDelegate.mapViewIdle(_:)))
            .map(toNMFMapView)
        return ControlEvent(events: source)
    }
    
    // delegate.mapViewCameraUpdateCancel(mapView: NMFMapView, byReason: Int)
    public typealias NMFCameraEvent = (mapView: NMFMapView, byReason: Int)
    func toNMFCameraEvent(_ args: [Any]) throws -> NMFCameraEvent {
        let mapView = try castOrThrow(NMFMapView.self, args[0])
        let byReason = try castOrThrow(Int.self, args[1])
        return (mapView, byReason)
    }
    public var mapViewCameraUpdateCancel: ControlEvent<NMFCameraEvent> {
        let source: Observable<NMFCameraEvent> = delegate
            .methodInvoked(#selector(NMFMapViewDelegate.mapViewCameraUpdateCancel(_:byReason:)))
            .map(toNMFCameraEvent)
        return ControlEvent(events: source)
    }
    
    // delegate.didTapMapView(point: CGPoint, latLng: NMGLatLng)
    public typealias NMFTouchEvent = (latlng: NMGLatLng, point: CGPoint)
    func toNMFTouchEvent(_ args: [Any]) throws -> NMFTouchEvent {
        let latlng = try castOrThrow(NMGLatLng.self, args[0])
        let point = try castOrThrow(CGPoint.self, args[1])
        return (latlng, point)
    }
    /// 맵뷰를 터치했을 때 호출됩니다. 터치한 곳의 실제 좌표와 기기상 좌표가 전달됩니다.
    public var didTapMapView: ControlEvent<NMFTouchEvent> {
        let source: Observable<NMFTouchEvent> = delegate
            .methodInvoked(#selector(NMFMapViewDelegate.didTapMapView(_:latLng:)))
            .map(toNMFTouchEvent)
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: NMFMapView {
    /// 맵뷰의 이동이 멈췄을 때, 중앙에 있는 곳의 좌표가 전달됩니다.
    public var currentCoordinates: Observable<NMGLatLng> {
        return delegate.methodInvoked(#selector(NMFMapViewDelegate.mapViewIdle(_:)))
            .map { parameters in
                guard let mapView = parameters[0] as? NMFMapView else {
                    return NMGLatLng(lat: 0, lng: 0)
                }
                return NMGLatLng(lat: mapView.latitude, lng: mapView.longitude)
            }
    }
}
