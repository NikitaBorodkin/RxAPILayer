//
//  APIClientConfiguration.swift
//  Reddit-RxSwiftTraining
//
//  Created by Никита on 25.08.17.
//  Copyright © 2017 Noveo. All rights reserved.
//

import Foundation

public struct APIClientConfiguration {
    public var timeout: Double = 15
    public var sessionType: URLSessionConfiguration = URLSessionConfiguration.default
    public var defaultHeaders: [String : String] = [:]
    
    public static func defaultConfiguration() -> APIClientConfiguration {
        let configuration = APIClientConfiguration()
        configuration.sessionType.timeoutIntervalForRequest = configuration.timeout
        return configuration
    }
}
