//
//  RequestData.swift
//  RxSwiftTraining
//
//  Created by Никита on 31.07.17.
//  Copyright © 2017 Noveo. All rights reserved.
//

import Alamofire
import Foundation

struct RequestData {
    var endPoint: String
    var parameters: [String : Any]
    var headers: [String : String]
    var method: Alamofire.HTTPMethod
    
    init(endPoint: String, parameters: [String : Any] = [:], headers: [String : String] = [:], method: Alamofire.HTTPMethod) {
        self.method = method
        self.endPoint = endPoint
        self.headers = headers
        self.parameters = parameters
    }
}
