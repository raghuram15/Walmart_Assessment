//
//  CoreDataManager.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation
import CoreData

struct NasaDataManager {
    
    
    private let _nasaDataRepository = NasaDataRepository()
    
    func saveData(data: NasaData) {
        _nasaDataRepository.saveData(data: data)
    }
    
    func getAll() -> [NasaData]? {
     
        return _nasaDataRepository.getAll()
    }
    
    func update(data: NasaData) -> Bool{
     
        return _nasaDataRepository.update(data: data)
    }
}
