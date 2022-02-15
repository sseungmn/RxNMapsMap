//
//  Utils.swift
//  RxNMapsMap
//
//  Created by SEUNGMIN OH on 2022/02/15.
//

import Foundation
import RxCocoa

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
