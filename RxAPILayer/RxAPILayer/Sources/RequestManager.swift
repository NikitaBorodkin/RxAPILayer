//
//  RequestManager.swift
//  RxSwiftTraining
//
//  Created by Никита on 20.07.17.
//  Copyright © 2017 Noveo. All rights reserved.
//

import RxSwift
import Alamofire
import AlamofireImage

import Foundation

open class RequestManager {
    
    // MARK: - Private Properties

    private var sessionManager: Alamofire.SessionManager!
    
    // MARK: - Lifecycle
    
    public init(with configuration: APIClientConfiguration) {
        reconfigure(with: configuration)
    }
    
    // MARK: - Service Methods
    
    public func reconfigure(with configuration: APIClientConfiguration) {
        self.sessionManager = Alamofire.SessionManager(configuration: configuration.sessionType)
    }
    
    // MARK: - Public Methods
    
    public func perform<T: Decodable>(request: RequestData, appId: String = "", appSecret: String = "") -> Observable<T> {
        return Observable<T>.create { subscriber -> Disposable in
            let dataRequest = self.configureRequest(by: request, appId: appId, appSecret: appSecret)
            
            // Debuging
            print("REQUEST: ", dataRequest.debugDescription, "\n")
            ///////////
            
            dataRequest
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            subscriber.onNext(result)
                            subscriber.onCompleted()
                        }
                        catch {
                            subscriber.onError(error)
                        }
                        
                    case .failure(let error):
                        subscriber.onError(error)
                    }
                }
            
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
    
    public func perform(imageRequest: RequestData, appId: String = "", appSecret: String = "") -> Observable<Image> {
        return Observable<Image>.create { subscriber -> Disposable in
            let dataRequest = self.configureRequest(by: imageRequest, appId: appId, appSecret: appSecret)
            
            // Debuging
            print("REQUEST: ", dataRequest.debugDescription, "\n")
            ///////////
            
            dataRequest.responseImage { response in
                switch response.result {
                case .success(let image):
                    subscriber.onNext(image)
                    
                case .failure(let error):
                    subscriber.onError(error)
                }
            }
            
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
    
    // MARK: - Service Methods
    
    private func configureRequest(by request: RequestData, appId: String, appSecret: String) -> DataRequest {
        let encoding: ParameterEncoding = request.method == .get ? URLEncoding.default : JSONEncoding.default
        let resultRequest = sessionManager.request(request.endPoint,
                                      method: request.method,
                                      parameters: request.parameters,
                                      encoding: encoding,
                                      headers: request.headers)

        resultRequest.authenticate(user: appId, password: appSecret)
        return resultRequest
    }
}
