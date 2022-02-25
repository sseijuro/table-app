//
//  NetworkManager.swift
//  table-app
//
//  Created by Alexandr Kozorez on 21.02.2022.
//

import Foundation

class BaseNetworkService: NSObject {
    private let session: URLSession = {
        let config: URLSessionConfiguration = .default
        config.urlCache = URLCache(
            memoryCapacity: 25_000_000,
            diskCapacity: 200_000_000,
            directory: FileManager.default
                        .urls(for: .cachesDirectory, in: .userDomainMask)[0]
                        .appendingPathComponent("download.cache")
        )
        return URLSession(configuration: config)
    }()
    
    private func httpMiddleware(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
                  throw NetworkServiceError.network
              }
        return data
    }
    
    func getJson<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkServiceError>) -> Void
    ) {
        var requestURL = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        requestURL.httpMethod = "GET"
        session.dataTask(with: requestURL) { rawData, response, error in
            do {
                let data = try self.httpMiddleware(data: rawData, response: response)
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let error as NetworkServiceError {
                print(error)
                completion(.failure(error))
            } catch let unknownError {
                print(unknownError)
                completion(.failure(.unknown))
            }
        }.resume()
    }
    
    func getData(url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        var requestURL = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        requestURL.httpMethod = "GET"
        session.dataTask(with: requestURL) { rawData, response, error in
            do {
                let data = try self.httpMiddleware(data: rawData, response: response)
                completion(.success(data))
            } catch let error as NetworkServiceError {
                print(error)
                completion(.failure(error))
            } catch let unknownError {
                print(unknownError)
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
