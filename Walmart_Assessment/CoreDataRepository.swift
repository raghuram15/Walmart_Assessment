//
//  CoreDataRepository.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation
import CoreData

protocol NasaRepository {
    
    func saveData(data: NasaData)
    func getAll() -> [NasaData]?
    func update(data: NasaData) -> Bool
}

struct NasaDataRepository: NasaRepository {
    func saveData(data: NasaData) {
        let cdNasaData = CDNasa(context: PersistentStorage.shared.context)
        cdNasaData.title = data.title
        cdNasaData.hdurl = data.hdurl
        cdNasaData.explanation = data.explanation
        cdNasaData.date = data.date
        cdNasaData.id = data.id
        cdNasaData.image = data.image
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [NasaData]? {
        
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDNasa.self)
        
        var nasaResults: [NasaData] = []
        result?.forEach({ (cdNasa) in
            nasaResults.append(cdNasa.convertToNasaData())
        })
        
        return nasaResults
    }
    
    func update(data: NasaData) -> Bool{
        
        let cdNasaData = getCDNasa(byIdentifier: data.id)
        guard cdNasaData != nil else {return false}
        
        cdNasaData?.title = data.title
        cdNasaData?.hdurl = data.hdurl
        cdNasaData?.explanation = data.explanation
        cdNasaData?.date = data.date
        cdNasaData?.id = data.id
        cdNasaData?.image = data.image
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
   
    
    private func getCDNasa(byIdentifier id: UUID) -> CDNasa? {
        
        
        let fetchRequest = NSFetchRequest<CDNasa>(entityName: "CDNasa")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else {return nil}
            return result
        }catch let error {
            print(error)
        }
        
        return nil
    }
    
    
}
