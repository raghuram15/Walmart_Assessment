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
        
         checkIfDataExists()
       
    }

   
    private func checkIfDataExists(){
        
        let now = Date.now
        let today = now.formatted(.iso8601.year().month().day().dateSeparator(.dash))
     
        if (UserDefaults.standard.string(forKey: "FIRSTLAUNCH") == today){
           print("Not a FIRSTLAUNCH \(today)")
            fetchFromCoreData()
        }else{
           UserDefaults.standard.set(today, forKey: "FIRSTLAUNCH")
           if Reachability.isConnectedToNetwork(){
                fetchJsonData()
            }else{
                displayAlert(alertMessage: "Internet Connection not Available!")
            }
           
        }
        
    }
   
}

extension ViewController {
    
    
    private func fetchFromCoreData(){
        
        nasaData = manager.getAll()
        if(nasaData != nil && nasaData?.count != 0) {
            if let imageData = nasaData?[0].image{
                self.imageView.image = UIImage(data: imageData)
            }
            self.title = nasaData?[0].title
            textView.text = nasaData?[0].explanation
        }else {
            fetchJsonData()
        }
    }
    
    
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
    
    
    private func displayAlert(alertMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

