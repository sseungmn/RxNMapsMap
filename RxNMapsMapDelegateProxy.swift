//
//  RxNMapsMapDelegateProxy.swift
//  RxNMapsMap
//
//  Created by SEUNGMIN OH on 2022/02/15.
//

import Foundation
import NMapsMap
import RxCocoa

public class RxNMFMapViewDelegateProxy: DelegateProxy<NMFMapView, NMFMapViewDelegate>, DelegateProxyType, NMFMapViewDelegate {
    
    public static func registerKnownImplementations() {
        self.register { (mapView) -> RxNMFMapViewDelegateProxy in
            RxNMFMapViewDelegateProxy(parentObject: mapView, delegateProxy: self)
        }
    }
    
    public static func currentDelegate(for object: NMFMapView) -> NMFMapViewDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: NMFMapViewDelegate?, to object: NMFMapView) {
        object.delegate = delegate
    }
}
