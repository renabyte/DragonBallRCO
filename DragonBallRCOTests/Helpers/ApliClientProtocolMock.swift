//
//  ApliClientProtocolMock.swift
//  DragonBallRCOTests
//
//  Created by Renato Calderon on 30/09/24.
//

import Foundation
@testable import DragonBallRCO

final class ApliClientProtocolMock<C: Codable>: APIClientProtocol {
    
    
    
    var session: URLSession = .shared
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    var receiveResult: Result<C, NetworkError>?
    
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, DragonBallRCO.NetworkError>) -> Void) {
    }
    
    func reg(_ request: URLRequest, completion: @escaping (Result<String, DragonBallRCO.NetworkError>) -> Void) {
        
    }
    
    func request<T>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, DragonBallRCO.NetworkError>) -> Void) where T : Decodable {
        didCallRequest  = true
        receivedRequest = request
        
        if let result = receiveResult as? Result<T, NetworkError> {
            completion(result)
        }
    }
    
}

