//
//  NetworkManager.swift
//  table-app
//
//  Created by Alexandr Kozorez on 21.02.2022.
//

import Foundation

final class NetworkManager: NSObject, URLSessionDelegate {
    private let baseAPIaddr = "http://api.mediastack.com/v1/news?access_key=88fce32a9debc006260adcbce88aaee0"
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func fetch(completion: @escaping (News?) -> Void) {
        let task = session.dataTask(with: URL(string: baseAPIaddr)!) { data, response, error in
            guard error == nil, let data = data, let string = String(data: data, encoding: .utf8),
                  let jsonData = string.data(using: .utf8)
            else {
                print(error ?? "Unknown error")
                completion(nil)
                return
            }
            print(string)
            let decodedData = try? JSONDecoder().decode(News.self, from: string.data(using: .utf8)!)
            completion(decodedData)
        }
        task.resume()
    }
    
    private func download(withUrl url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                completion(error)
                return
            }
            do {
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }
                try FileManager.default.copyItem(at: tempURL, to: file)
                completion(nil)
                return
            }
            catch let fileError {
                completion(fileError)
                return
            }
        }
        task.resume()
    }
    
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let cachedFile = FileManager.default.temporaryDirectory.appendingPathComponent(
            url.lastPathComponent,
            isDirectory: false
        )
        
        if let data = try? Data(contentsOf: cachedFile) {
            completion(data, nil)
            return
        }
        
        download(withUrl: url, toFile: cachedFile) { (error) in
            let data = try? Data(contentsOf: cachedFile)
            completion(data, error)
            return
        }
    }
}

struct News {
    let pagination: Pagination
    let data: [Post]
}

struct Post {
    let title: String
    let description: String
    let published_at: String
    let image: String
}

struct Pagination {
    let limit: Int
    let offset: Int
    let count: Int
    let total: Int
}

extension News: Codable {}
extension Post: Codable {}
extension Pagination: Codable {}
