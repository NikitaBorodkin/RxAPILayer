//
//  APIClientConfiguration.swift
//  Reddit-RxSwiftTraining
//
//  Created by Никита on 25.08.17.
//  Copyright © 2017 Noveo. All rights reserved.
//

import Foundation

struct APIClientConfiguration {
    var timeout: Double = 15
    var sessionType: URLSessionConfiguration = URLSessionConfiguration.default
    var defaultHeaders: [String : String] = [:]
    
    static func defaultConfiguration() -> APIClientConfiguration {
        let configuration = APIClientConfiguration()
        configuration.sessionType.timeoutIntervalForRequest = configuration.timeout
        return configuration
    }
}
