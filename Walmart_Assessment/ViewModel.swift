//
//  ViewModel.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation

class ContentViewModel {
    
    private let userRepository: UserRepositoryDelegate
    
    init(userRepository: UserRepositoryDelegate = UserRepository()) {
        self.userRepository = userRepository
    }
    
    
    func getJsonPlaceHolderData(completion: @escaping(Result<Response, CustomError>) -> Void){
        
        userRepository.getJsonPlaceHolderUser(completion: completion)
        }
    }
