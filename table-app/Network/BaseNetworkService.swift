//
//  NetworkManager.swift
//  table-app
//
//  Created by Alexandr Kozorez on 21.02.2022.
//

import Foundation

final class NetworkService: NSObject {
    private let config: URLSessionConfiguration
    private let session: URLSession
    private let queue = DispatchQueue(label: "network.service.queue", qos: .background)
    private let group = DispatchGroup()
    private let decoder = JSONDecoder()
    
    private let baseAPIPath = "https://pokeapi.co/api/v2/pokemon/"
    
    override init() {
        self.config = .default
        self.config.urlCache = URLCache(
            memoryCapacity: 25_000_000,
            diskCapacity: 200_000_000,
            directory: FileManager.default
                        .urls(for: .cachesDirectory, in: .userDomainMask)[0]
                        .appendingPathComponent("download.cache")
        )
        self.session = URLSession(configuration: config)
        super.init()
    }
    
}

extension NetworkService {
    func fetchPokemonInfo(withId id: Int, completion: @escaping (Result<Pokemon, NetworkServiceError>) -> Void) {
        let fetchURL = URL(string: baseAPIPath + String(id))!
        var fetchRequest = URLRequest(url: fetchURL)
        fetchRequest.httpMethod = "GET"
        
        session.dataTask(with: fetchRequest, completionHandler: { rawData, response, error in
            do {
                let data = try self.httpMiddleware(data: rawData, response: response)
                let response = try self.decoder.decode(Pokemon.self, from: data)
                completion(.success(response))
            } catch let error as NetworkServiceError {
                print(error)
                completion(.failure(error))
            } catch let error {
                print(error)
                completion(.failure(.unknown))
            }
        }).resume()
    }
    
    func httpMiddleware(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
                  throw NetworkServiceError.network
              }
        return data
    }
}
