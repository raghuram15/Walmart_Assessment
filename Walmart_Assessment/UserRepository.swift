//
//  UserRepository.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation

import Foundation

protocol UserRepositoryDelegate {
    
    func getJsonPlaceHolderUser(completion: @escaping(Result<Response, CustomError>) -> Void)
}

class UserRepository: UserRepositoryDelegate {
    
    
    private let networkManager: NetworkManagerDelegate
    
    init(networkManager: NetworkManagerDelegate = URLSessionNetworkManager()){
        self.networkManager = networkManager
    }
    
    func getJsonPlaceHolderUser(completion: @escaping (Result<Response, CustomError>) -> Void) {
        
        networkManager.getData(urlString: "https://api.nasa.gov/planetary/apod?api_key=\(Constants.apiKey)", completionHandler: completion)
    }
}
