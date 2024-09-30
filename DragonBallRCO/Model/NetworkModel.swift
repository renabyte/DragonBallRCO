//
//  NetworkModel.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 25/09/24.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel()
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String?
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        // Este string se creara con el siguiente formato:
        // (user):(password)
        // adri4silva@gmail.com:abcdef
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.noData))
            return
        }
        // Encryptamos los datos que acabamos de crear
        // Utilizamos un algoritmo de encriptacion para no pasarle
        // el usuario y la contraseña en texto plano.
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        client.jwt(request) { [weak self] result in
            switch result {
                case let .success(token):
                    self?.token = token
                case .failure:
                    break
            }
            completion(result)
        }
    }
    
    func register(
        name: String,
        lastName: String,
        lastName2: String,
        email: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/register/developer"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": name, "apell1": lastName, "apell2": lastName2, "email": email, "password": password , "bootcamp": "151204B2-441E-4C13-AF51-475F02C99622" , "photo": "https://media-exp1.licdn.com/dms/image/C4E03AQHLnB5e8bcFBA/profile-displayphoto-shrink_800_800/0/1642765623814?e=1650499200&v=beta&t=-hl8i-nYg7N6bdnm3QW89NuE9O-IRb3sdfZ1-CMeHkk"] ) else {
            completion(.failure(.unknown))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.reg(request) { [weak self] result in
            switch result {
                case let .success(clave):
                    self?.token = clave
                case .failure:
                    break
            }
            completion(result)
        }
    }
    
    func getHeroes(
        completion: @escaping (Result<[Hero], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else {
            completion(.failure(.unknown))
            return
        }
        
        guard let token else {
            completion(.failure(.unknown))
            return
        }
        /*let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUifQ.eyJlbWFpbCI6InF1aW9zY29zLXRleHR1YWwwckBpY2xvdWQuY29tIiwiaWRlbnRpZnkiOiI4NEEyQ0U2Ni05RDBBLTQzMjAtQjk2Mi1DNjU2OERDMzAxMkMiLCJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMH0.z9534WMqPhUFyA385JhbKX4Xm_Fb5-38I8-d1LjtK9s" */
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.request(request, using: [Hero].self, completion: completion)
    }
    
    func getTransformations(
        for hero: Hero,
        completion: @escaping (Result<[Transformation], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": hero.id]) else {
            completion(.failure(.unknown))
            return
        }
        
        guard let token else {
            completion(.failure(.unknown))
            return
        }
        /*let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUifQ.eyJlbWFpbCI6InF1aW9zY29zLXRleHR1YWwwckBpY2xvdWQuY29tIiwiaWRlbnRpZnkiOiI4NEEyQ0U2Ni05RDBBLTQzMjAtQjk2Mi1DNjU2OERDMzAxMkMiLCJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMH0.z9534WMqPhUFyA385JhbKX4Xm_Fb5-38I8-d1LjtK9s" */
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.request(request, using: [Transformation].self, completion: completion)
    }
    
    func getBootcamps(
        completion: @escaping (Result<[Bootcamps], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/data/bootcamps"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        client.request(request, using: [Bootcamps].self, completion: completion)
    }
}
