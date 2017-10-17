//
//  BaseAPIClient.swift
//  Reddit-RxSwiftTraining
//
//  Created by Никита on 16.10.2017.
//  Copyright © 2017 Noveo. All rights reserved.
//

import Foundation

open class BaseAPIClient {
    
    // MARK: - Private Properties
    
    public let baseURL: String
    public var requestManager: RequestManager
    
    // MARK: - Public Properties
    
    public var configuration: APIClientConfiguration {
        didSet {
            requestManager.reconfigure(with: configuration)
        }
    }
    
    // MARK: - Lifecycle
    
    public init(baseURL: String, configuration: APIClientConfiguration = APIClientConfiguration.defaultConfiguration()) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.requestManager = RequestManager(with: configuration)
    }
    
    // MARK: - Service Methods
    
    public func updateConfiguration(with token: Int) {
        requestManager.reconfigure(with: configuration)
    }
}
