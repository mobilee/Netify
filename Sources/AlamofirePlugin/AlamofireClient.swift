//
//  AlamofireClient.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Alamofire
import Foundation

public class AlamofireClient: APIClient {

    public static let queueName: String = "alamofire.client.network.queue"

    /**
     Show logs if yes. Default set as *true*. Logging works only in debug mode.
     */
    public var showLogs: Bool = true
    let manager: Alamofire.Session
    public let decoder: JSONDecoder = JSONDecoder() // consider to delete?
    public let queue: DispatchQueue
    
    public init() {
        let conf = URLSessionConfiguration.default
        conf.timeoutIntervalForResource = 40.0
        
        self.queue = DispatchQueue(label: Self.queueName,
                                  qos: .userInitiated,
                                  attributes: DispatchQueue.Attributes.concurrent,
                                  target: nil)

        self.manager = Alamofire.Session(configuration: conf, rootQueue: queue)
    }
    
    @discardableResult
    public func executeRequest<T: Endpoint>(route: T, completion: @escaping T.Completion) -> DataRequest {
        
        var preprocessor: DataPreprocessor
        if let keyPath = route.keyPath {
            preprocessor = KeyPathPresprocessor(keyPath: keyPath)
        } else {
            preprocessor = PassthroughPreprocessor()
        }
        
        #if DEBUG
        if showLogs == true {
            print(route.debugDescription)
        }
        #endif
        
        let reqModel = manager.request(route.request).responseDecodable(of: T.Model.self, dataPreprocessor: preprocessor) { (response) in
            
            let castedResponse = response.mapError { (aferror) -> Error in
                #if DEBUG
                debugPrint(aferror)
                #endif
                
                return aferror
            }

            if let error = response.error, let errorHandler = type(of: route.api).defaultErrorHandler, errorHandler(error) == true {
                return
            } else {
                completion(castedResponse.result)
            }
        }

        // add validation and executing
        
        return reqModel
    }
}
