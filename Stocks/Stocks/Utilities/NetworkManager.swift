//
//  NetworkManager.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

/// This class is used to manage  network  requests
public class NetworkManager {
    typealias StockCompletionClosure = ((StocksData?, Error?) -> Void)
    
    static let shared = NetworkManager()
    
    func fetchData(completion: StockCompletionClosure?) {
        guard let url = Constants.dataUrl else { return }
        guard let request = createRequest(for: url) else {
            completion?(nil, NetworkError.invalidUrl)
               return
           }
           executeRequest(request: request, completion: completion)
    }
    
    private func createRequest(for url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
