//
//  NetworkManager.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation
enum CustomError: Error{
    
    case genericError
}


protocol NetworkManagerDelegate {
    
    func getData<T: Decodable>(urlString: String, completionHandler: @escaping(Result<T,CustomError>) -> Void)
}

class URLSessionNetworkManager: NetworkManagerDelegate {
    
    func getData<T: Decodable>(urlString: String, completionHandler: @escaping (Result<T, CustomError>) -> Void)  {
        
        guard let url = URL(string: urlString) else {return completionHandler(.failure(.genericError))}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, let list = try? JSONDecoder().decode(T.self, from: data) else {
                    return completionHandler(.failure(.genericError))}
                
                completionHandler(.success(list))
                }
        }.resume()
        }
    }
