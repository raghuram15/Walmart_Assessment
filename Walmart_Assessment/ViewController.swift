//
//  ViewController.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var nasaData : [NasaData]? = nil
    
    private let manager: NasaDataManager = NasaDataManager()
    
    var viewModel = ContentViewModel()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
        
        let now = Date.now
        let today = now.formatted(.iso8601.year().month().day().dateSeparator(.dash))
     
        
        // Do any additional setup after loading the view.
        if (UserDefaults.standard.string(forKey: "FIRSTLAUNCH") == today){
           print("Not a FIRSTLAUNCH \(today)")
        }else{
            print("FIRSTLAUNCH \(today)" , "----", "\(UserDefaults.standard.string(forKey: "FIRSTLAUNCH"))")
            UserDefaults.standard.set(today, forKey: "FIRSTLAUNCH")
           
        }
       
        

        
        nasaData = manager.getAll()
        if(nasaData != nil && nasaData?.count != 0) {
            print(nasaData?[0].title, "I am title", nasaData?[0].id)
            if let imageData = nasaData?[0].image{
                self.imageView.image = UIImage(data: imageData)
            }
            self.title = nasaData?[0].title
            textView.text = nasaData?[0].explanation
            
            //            let saveData = NasaData(date: "responseArray.date", explanation: "responseArray.explanation," ,hdurl: "responseArray.hdurl", media_type: "responseArray.media_type", service_version: "responseArray.service_version", title: "responseArray.title," ,url: "responseArray.url", id: (nasaData?[0].id)!, image: nasaData?[0].image)
            //
            //            if manager.update(data: saveData){
            //                print(nasaData?[0].title, "I am title", nasaData?[0].id)
            //            }
        }else {
            
            fetchJsonData()
        }
    }

   
    
   
    
}

extension ViewController {
    
    
    private func fetchJsonData(){
        print("fetchinggg JSon Data....")
        viewModel.getJsonPlaceHolderData { result in
            
            switch result {
                
            case .success(let success):
                print(success)
                self.updateView(responseArray: success)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    private func updateView(responseArray: Response) {
        
        // Create URL
        let imageUrl = URL(string:  responseArray.hdurl!)!
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async { [self] in
                    // Create Image and Update Image View
                    print(data, "data123")
                    self.imageView.image = UIImage(data: data)
                    
                    let saveData = NasaData(date: responseArray.date, explanation: responseArray.explanation, hdurl: responseArray.hdurl, media_type: responseArray.media_type, service_version: responseArray.service_version, title: responseArray.title, url: responseArray.url, id: UUID(), image: data)
                     manager.saveData(data: saveData)
//
                }
            }
        }
        self.title = responseArray.title
        textView.text = responseArray.explanation
    }
}

