//
//  RequestData.swift
//  RxSwiftTraining
//
//  Created by Никита on 31.07.17.
//  Copyright © 2017 Noveo. All rights reserved.
//

import Alamofire
import Foundation

public struct RequestData {
    public var endPoint: String
    public var parameters: [String : Any]
    public var headers: [String : String]
    public var method: Alamofire.HTTPMethod
    
    public init(endPoint: String, parameters: [String : Any] = [:], headers: [String : String] = [:], method: Alamofire.HTTPMethod) {
        self.method = method
        self.endPoint = endPoint
        self.headers = headers
        self.parameters = parameters
    }
}
