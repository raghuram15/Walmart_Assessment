//
//  ResponseModel.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//

import Foundation

struct Response: Codable {
    
    let date: String?
    let explanation: String?
    let hdurl: String?
    let media_type: String?
    let service_version: String?
    let title: String?
    let url: String?
}